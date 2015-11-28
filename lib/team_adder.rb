class TeamAdder
  def initialize(teamable:)
    @teamable = teamable
  end

  def from_leagues(season, level, size)
    leagues = season.leagues.where(level: level)
    leagues.each {|league| teamable.teams.concat ranked(league, size) }
    teamable
  end

  def ranked(league, size)
    LeagueRepository::Ranking
      .new(league: league)
      .first(size)
  end

  private

  attr_reader :teamable
end
