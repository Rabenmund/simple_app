class Season < ActiveRecord::Base
  validates :year, numericality: true, presence: true
  has_and_belongs_to_many :federations
  has_many :appointments, through: :competitions
  has_many :competitions
  has_many :matchdays, through: :competitions
  has_many :games, through: :matchdays
  has_many :results, through: :leagues
  has_many :leagues
  has_many :cups
  has_many :relegations
  has_many :teams, -> { uniq }, through: :competitions

  def teardown!
    return false if appointments.any?
    leagues.each do |l|
      l.finish!
    end
    DFBPattern.new(season: create_next).prepare!
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
    Season.find_by(year: year-1)
  end

  private

  def create_next
    _start = DateTime.new((year), 8, 2, 15, 30)
    _start += (6 - _start.wday)
    _end = end_date + 1.year
    Season.create(
      year: year+1,
      start_date: _start,
      end_date: _end,
    )
  end
end
