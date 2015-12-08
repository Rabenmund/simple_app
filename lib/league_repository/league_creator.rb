module LeagueRepository
  class LeagueCreator
    attr_accessor :league

    def initialize(attributes)
      @league = League.new(attributes)
    end

    def add_teams(teams)
      teams.each {|team| league.teams << team }
    end

    def ensure_team_size(size)
      LeagueUseCase::FillUpWithTeams
        .new(league: league, size: size)
        .random
    end

    def save!
      league.save!
    end

    def plan_games_for(teams)
      LeagueUseCase::GamesPlanner
        .new(league: league)
        .call
    end
  end
end
