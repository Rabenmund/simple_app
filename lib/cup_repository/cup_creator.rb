module CupRepository
  class CupCreator
    def initialize(season:, previous:, federation:)
      @season = season
      @previous = previous
      @federation = federation
    end

    def by_plan(plan)
      @plan = plan
      add_teams_to new_cup
    end

    private

    attr_reader :season, :previous, :federation
    attr_accessor :plan, :cup

    def add_teams_to(cup)
      plan.qualified.leagues.each do |level, size|
        cup = adder.from_leagues(previous, level, size)
      end

      cup = adder.randomly(available_teams(cup.teams),
                           missing_team_number(cup.teams.size))
    end

    def new_cup
      @cup = Cup.create(
        level: plan.level,
        name: plan.name,
        season: season,
        federation: federation,
        start: season.start_date
      )
    end

    def available_teams(teams)
      federation.teams - teams
    end

    def missing_team_number(already_added)
      plan.teams_no - already_added
    end

    def adder
      @adder ||= TeamAdder.new(teamable: cup)
    end
  end
end
