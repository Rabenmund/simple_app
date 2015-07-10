class Team < ActiveRecord::Base
  has_one :organization, as: :organizable
  has_many :contracts, through: :organization
  has_many :humen, through: :contracts
  has_many :professions, through: :humen
  has_many :players,
    through: :professions,
    source: "professionable",
    source_type: 'Player'

  belongs_to :federation
  has_and_belongs_to_many :competitions
  has_many :seasons, through: :competitions
  has_many :home_games, class_name: "Game", foreign_key: "home_id"
  has_many :guest_games, class_name: "Game", foreign_key: "guest_id"
  has_many :games, through: :competitions
  has_many :points
  has_many :results
  has_many :offers

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :short_name, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :abbreviation, presence: true, length: { maximum: 3 }, uniqueness: true
  validates :federation, presence: true

  scope :without_players, -> {
    includes(:players).
    includes(:contracts).
    where(contracts: {organization_id: nil}).
    uniq
  }

  scope :with_league_in, ->(season) {
    joins(:seasons).where("seasons.id = ?", season.id).
    joins(:competitions).where(competitions: {type: "League"}).
    uniq
  }

  def self.strength
    joins(:players).
      select(:id, "SUM(players.keeper + players.defense + players.midfield + players.attack)").
      group("teams.id").
      order("sum DESC")
  end

  def strength
    players.strength
  end

  def best_lineup
    # TODO Single SQL Query possible ??

    # joins(:players).
    #   select(:id, "((SELECT * from players WHERE players.keeper = 0 SUM(players.keeper))+ SUM(players.defense)) as sum").
    #   group("teams.id").
    #   order("sum DESC")
  end

  def keepers
    players.find_all{|p| p.keeper?}
  end

  def defenders
    players.find_all{|p| p.defender?}
  end

  def midfielders
    players.find_all{|p| p.midfielder?}
  end

  def attackers
    players.find_all{|p| p.attacker?}
  end

  def games
    Game.where("games.home_id = #{id} OR games.guest_id = #{id}")
  end

  def broker
    PlayerExchangeBroker.new(
      team: self,
      keepers: PlayerNeed.new(3, keepers.size).need,
      defenders: PlayerNeed.new(FORMATION[:defenders]*2, defenders.size).need,
      midfielders: PlayerNeed.new(FORMATION[:midfielders]*2, midfielders.size).need,
      attackers: PlayerNeed.new(FORMATION[:attackers]*2, attackers.size).need
    ) if need?
  end

  def need?
    players.size < MAX_PLAYERS
  end

  MAX_PLAYERS = 23

  FORMATION={
    defenders: 4,
    midfielders: 4,
    attackers: 2
  }

  LEAGUE = {
    1 => 150,
    2 => 100,
    3 => 50,
  }

  def reputation
    return rand(75) unless current_league
    current = LEAGUE[current_league.level] + current_points
    return current unless previous_league
    current + LEAGUE[previous_league.level] + previous_points
  end

  def current_league
    @current_league ||= Season.current.league_for(self)
  end

  def current_points
    current_league.points_for(self) || 0
  end

  def previous_league
    current_league.previous
  end

  def previous_points
    previous_league.points_for(self) || 0
  end

end
