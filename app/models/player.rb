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

  scope :without_offer_by, ->(team_id, date) {
    joins('LEFT OUTER JOIN offers ON offers.player_id = players.id')
      .where("(players.id NOT IN ("\
             "SELECT offers.player_id "\
             "FROM offers "\
             "WHERE offers.team_id = ? "\
             "AND offers.negotiated IS FALSE "\
             "AND offers.start_date >= ?"\
          "))",
          team_id, date)
      .uniq
  }
  scope :without_contract_at, ->(date) do
    joins(:human)
    .joins('LEFT OUTER JOIN contracts '\
           'ON contracts.human_id = humen.id')
    .where('(GREATEST(contracts.to) < ?) OR contracts.id IS NULL', date)
  end

  scope :without_too_many_hard_competitors, ->(reputation) do
    joins('LEFT OUTER JOIN offers '\
           'ON offers.player_id = players.id')
    .where("((SELECT COUNT(*) FROM offers "\
             "where (offers.player_id = players.id "\
                    "AND offers.negotiated = false "\
                    "AND offers.reputation > ?)
             ) < 3) "\
            "OR offers.id IS NULL ", reputation)
  end


  def self.strength
    sum("players.keeper + players.defense + players.midfield + players.attack")
  end

  def self.linable
    active#.
    # wir brauchen polymorphe PlayerZustände, die einen Abwesenheitstyp haben
    # und ein until date
    # joins('LEFT OUTER JOIN zustaende ON zustaende.human_id = professions.human_id').
    # where("NOT (zustaende.unavailable = TRUE AND zustaende.until > ?) OR (zustaende.id IS NULL)", LogicalDate)
  end

  delegate :birthday, :name, :age, to: :human

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

  def main_strength
    Array.new(strengths.map{|type| send(type)}).max
    # [keeper, defense, midfield, attack].max
  end

  def main_type
    strengths.each do |strength|
      if is_main_strength?(send(strength))
        return STRENGTH[strength].to_s.singularize.to_sym
      end
    end
    strengths.first
  end

  private

  def strengths
    [:keeper, :defense, :midfield, :attack]
  end

  def nearby(main, strength)
    strength > main * 0.9
  end

  def is_main_strength?(strength)
    strength == main_strength
  end

end
