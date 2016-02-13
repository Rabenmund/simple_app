class Lineup < ActiveRecord::Base
  belongs_to :team # ? thru game ?
  belongs_to :game
  has_many :actors, class_name: "LineupActor"
  has_many :keepers, -> { where type: "Keeper" }
  has_many :defenders, -> { where type: "Defender" }
  has_many :midfielders, -> { where type: "Midfielder" }
  has_many :attackers, -> { where type: "Attacker" }
  has_many :players, through: :actors, source: :actorable, source_type: "Player"

  def reset!
    lineup!
    calculate_strength
  end

  def start!
    lineup! unless linedup?
    calculate_strength
  end

  private

  def linedup?
    actors.any?
  end

  def lineup!
    actors.delete_all
    system.each do |role, value|
      best_players(role, value).each do |player|
        send(role.to_s).create(actorable: player)
      end
    end
  end

  # TODO put that into a seperate and specific strength/system class

  def best_players(role, value)
    team.players
      .linable
      .send(role.to_s)
      .first(value)
  end

  def tactic
    # yes, later
  end

  def system
    { keepers: 1,
      defenders: 4,
      midfielders: 4,
      attackers: 2
    }
    # TODO: parameterize later
  end

  def calculate_strength
    update_attributes(
      initiative: calculate_initiative,
      attacking: calculate_attacking,
      defending: calculate_defending
    )
  end

  def strength_for(act)
    # players.strength_for(id, act)
    players.sum act
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
