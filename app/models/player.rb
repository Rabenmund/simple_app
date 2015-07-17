class Player < ActiveRecord::Base
  has_one :profession, as: :professionable
  has_one :human, through: :profession
  has_many :contracts, through: :human
  has_many :organizations, through: :contracts
  has_many :teams,
    through: :organizations,
    source: "organizable",
    source_type: "Team"
  has_many :offers

  has_many :lineups, class_name: "LineupActor", as: :actorable
  has_many :keeps, -> { where type: "Keeper" }, as: :actorable
  has_many :defends, -> { where type: "Defender" }, as: :actorable
  has_many :midfields, -> { where type: "Midfielder" }, as: :actorable
  has_many :attacks, -> { where type: "Attacker" }, as: :actorable

  scope :keepers, -> { where.not(keeper: 0).order(keeper: :desc) }
  scope :defenders, -> { where.not(defense: 0).order(defense: :desc) }
  scope :midfielders, -> { where.not(midfield: 0).order(midfield: :desc) }
  scope :attackers, -> { where.not(attack: 0).order(attack: :desc) }

  scope :active, -> { joins(:profession).where("professions.active = TRUE") }
  scope :without_offer_by, ->(team) {

    joins('LEFT OUTER JOIN offers ON offers.player_id = players.id').
    where('(players.id NOT IN (SELECT offers.player_id FROM offers WHERE offers.team_id = ? AND offers.negotiated IS FALSE))', team.id).
    uniq
  }

  # TODO still a try that does not work
  scope :without_better_offers, ->(number, reputation) {
    joins('LEFT OUTER JOIN offers ON offers.player_id = players.id').
    where(negotiated: false).
    find_by_sql("SELECT * from players WHERE players.id NOT IN (SELECT offers.player_id FROM offers WHERE (SELECT COUNT(*) FROM offers WHERE offers.reputation > #{reputation} GROUP BY offers.player_id) > 2)")#.
    # where('players.id NOT IN (SELECT offers.player_id FROM offers WHERE (SELECT COUNT (*) from offers where offers.reputation > ? GROUP BY offers.player_id) > 2 )', reputation).
  #   count('(offers.reputation > 100) = 0 AS better')
  #   where("NOT better > ? OR offers.id IS NULL", number)
    # uniq
  }

  def better_offers(reputation)
    offers.open.
    where('offers.reputation > ?', reputation).
    count
  end

  delegate :birthday, :name, :age, to: :human

  STRENGTH = { keeper: :keepers,
               defense: :defenders,
               midfield: :midfielders,
               attack: :attackers
  }

  def self.strength
    sum("players.keeper + players.defense + players.midfield + players.attack")
  end

  def self.contractable(season=Season.current)
    active.
    joins('LEFT OUTER JOIN contracts ON contracts.human_id = professions.human_id').
    where("(NOT contracts.to > ?) OR (contracts.id IS NULL)", season.start_date)
  end

  def self.linable
    active#.
    # wir brauchen polymorphe PlayerZustände, die einen Abwesenheitstyp haben
    # und ein until date
    # joins('LEFT OUTER JOIN zustaende ON zustaende.human_id = professions.human_id').
    # where("NOT (zustaende.unavailable = TRUE AND zustaende.until > ?) OR (zustaende.id IS NULL)", LogicalDate)
  end

  def keeper?
    nearby(main_strength, keeper)
  end

  def defender?
    nearby(main_strength, defense)
  end

  def midfielder?
    nearby(main_strength, midfield)
  end

  def attacker?
    nearby(main_strength, attack)
  end

  private

  def nearby(main, strength)
    strength > main * 0.9
  end

  def main_strength
    [keeper, defense, midfield, attack].max
  end

end
