class Player < ActiveRecord::Base
  has_one :profession, as: :professionable
  has_one :human, through: :profession
  has_many :contracts, through: :human
  has_many :organizations, through: :contracts
  has_many :teams,
    through: :organizations,
    source: "organizable",
    source_type: "Team"

  has_many :lineups, class_name: "LineupActor", as: :actorable
  has_many :keepers, -> { where type: "Keeper" }, as: :actorable
  has_many :defenders, -> { where type: "Defender" }, as: :actorable
  has_many :midfielders, -> { where type: "Midfielder" }, as: :actorable
  has_many :attackers, -> { where type: "Attacker" }, as: :actorable

  scope :keepers, -> { where.not(keeper: 0).order(keeper: :desc) }
  scope :defenders, -> { where.not(defense: 0).order(defense: :desc) }
  scope :midfielders, -> { where.not(midfield: 0).order(midfield: :desc) }
  scope :attackers, -> { where.not(attack: 0).order(attack: :desc) }

  delegate :birthday, to: :human

  STRENGTH = { keeper: :keepers,
               defense: :defenders,
               midfield: :midfielders,
               attack: :attackers
  }

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
