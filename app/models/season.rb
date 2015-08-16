class Season < ActiveRecord::Base
  validates :year, numericality: true, presence: true
  has_and_belongs_to_many :federations
  # has_many :appointments, through: :competitions
  has_many :competitions
  has_many :matchdays, through: :competitions
  has_many :games, through: :matchdays
  has_many :results, through: :leagues
  has_many :leagues
  has_many :cups
  has_many :relegations
  has_many :teams, -> { uniq }, through: :competitions

  def self.tearup!(year = (LogicalDate.year+1))
    season = Season.find_by(year: year)
    return season if season
    # TODO put DFBPattern into SeasonPatters where all patterns come together
    # SeasonPatterns.create_in new_season(year)
    DFBPattern.new(season: season_for!(year)).prepare!
  end

  def teardown!
    tearup_next!
  end

  def tearup_next!
    Season.tearup!(year + 1)
  end

  def self.current
    find_by(year: LogicalDate.current_season_year) || Season.last
  end

  def league_for(team)
    leagues.
      joins(:teams).
      where("teams.id = ?", team.id).
      first
  end

  def rank_for(league, team)
    league.rank_for(team)
  end

  def previous
    @previous ||= Season.find_by(year: year - 1)
  end

  def next_one
    @next ||= Season.find_by(year: year + 1)
  end

  private

  def self.season_for!(year)
    Season.create(
      year: year,
      start_date: DateTime.new((year-1), 7, 1),
      end_date: DateTime.new((year), 6, 30)
    )
  end

  # def create_next
  #   _start = DateTime.new((year), 8, 2, 15, 30)
  #   _start += (6 - _start.wday)
  #   _end = end_date + 1.year
  #   Season.create(
  #     year: year+1,
  #     start_date: _start,
  #     end_date: _end,
  #   )
  # end
end
