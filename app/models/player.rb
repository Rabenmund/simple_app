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

  STRENGTH = { keeper: :keepers,
               defense: :defenders,
               midfield: :midfielders,
               attack: :attackers
  }

  # def self.strength_for(lineup_id, act, actor=STRENGTH[act])
  #   joins(actor).
  #     where("lineup_actors" => {lineup_id: lineup_id}).
  #     sum(act)
  # end
end
