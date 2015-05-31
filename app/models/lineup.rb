class Lineup < ActiveRecord::Base
  belongs_to :team # ? thru game ?
  belongs_to :game
  has_many :actors, class_name: "LineupActor"
  has_many :keepers, -> { where type: "Keeper" }
  has_many :defenders, -> { where type: "Defender" }
  has_many :midfielders, -> { where type: "Midfielder" }
  has_many :attackers, -> { where type: "Attacker" }
  # has_many :attack_players, through: :actors, source: :actorable, source_type: "Attacker"

  def tearup
    if actors.empty?
      line_up_players
    end
    calculate_strength
  end

  def calculate_strength
    update_attributes(
      initiative: calculate_initiative,
      attacking: calculate_attacking,
      defending: calculate_defending
    )
  end

  private

  def system
    [4,4,2] # will be instantiated later
  end

  def line_up_players
    create_keeper
    create_defenders
    create_midfielders
    create_attackers
  end

  def create_keeper
    keepers.create(actorable: team.players.keepers[0])
  end

  def create_defenders(size=system[0])
    players = team.players.defenders.first(size)
    size.times { |p| defenders.create(actorable: players[p])}
  end

  def create_midfielders(size=system[1])
    players = team.players.midfielders.first(size)
    size.times { |p| midfielders.create(actorable: players[p])}
  end

  def create_attackers(size=system[2])
    players = team.players.attackers.first(size)
    size.times { |p| attackers.create(actorable: players[p])}
  end

  # TODO put that into a seperate calculation class

  def strength_for(act)
    Player.strength_for(id, act)
  end

  def calculate_initiative
    strength_for(:keeper)   *  1.00 +
    strength_for(:defense)  *  1.00 +
    strength_for(:midfield) *  2.00 +
    strength_for(:attack)   *  1.00
  end

  def calculate_attacking
    strength_for(:keeper)   *  0.00 +
    strength_for(:defense)  *  0.50 +
    strength_for(:midfield) *  1.00 +
    strength_for(:attack)   *  2.50
  end

  def calculate_defending
    strength_for(:keeper)   *  3.00 +
    strength_for(:defense)  *  2.50 +
    strength_for(:midfield) *  1.00 +
    strength_for(:attack)   *  0.50
  end
end
