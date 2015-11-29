class NotEnoughTeamsError < StandardError; end
class TeamAdder
  def initialize(teamable:)
    @teamable = teamable
  end

  def from_leagues(season, level, size)
    leagues = season.leagues.where(level: level)
    leagues.each {|league| teamable.teams.concat ranked(league, size) }
    teamable
  end

  def randomly(teams, size)
    fail NotEnoughTeamsError if teams.size < size
    size.times do
      team = teams[rand(teams.size)]
      teamable.teams << team
      teams = teams - [team]
    end
    teamable
  end

  private

  attr_reader :teamable

  def ranked(league, size)
    LeagueRepository::Ranking
      .new(league: league)
      .first(size)
  end
end
