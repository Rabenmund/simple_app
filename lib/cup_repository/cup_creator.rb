module CupRepository
  class TeamsSizeError < StandardError; end
  class CupCreator
    # TODO: Something to exxtract here ?

    def initialize(season:, previous:, federation:)
      @season = season
      @previous = previous
      @federation = federation
      @cup_start = SeasonUseCase::CompetitionStart.date_for(year: season.year)
    end

    def by_plan(plan)
      @plan = plan
      add_teams_to new_cup
      create_matchdays
      create_draws

      return cup
    end

    private

    attr_reader :season, :previous, :federation, :cup_start
    attr_accessor :plan, :cup

    def add_teams_to(cup)
      plan.qualified.leagues.each do |level, size|
        cup = adder.from_leagues(previous, level, size)
      end

      cup = adder.randomly(available_teams, missing_team_number)
    end

    def new_cup
      @cup = Cup.create(
        level: plan.level,
        name: plan.name,
        season: season,
        federation: federation,
        start: cup_start
      )
    end

    def available_teams
      federation.teams - cup.teams
    end

    def missing_team_number
      plan.teams_no - cup.teams.size
    end

    def adder
      @adder ||= TeamAdder.new(teamable: cup)
    end

    def create_matchdays
      number_of_matchdays.times do |n|
        MatchdayRepository::MatchdayCreator
          .create(competition_id: cup.id,
                  number: n+1,
                  start: start_date(n+1),
                  name: MATCHDAYS[teams_size][n+1]
                 )

      end
    end

    def create_draws
      cup.matchdays.each do |matchday|
        DrawRepository::DrawCreator
          .create(matchday: matchday, cup: cup)
      end
    end

    MATCHDAYS = {
      64 => {
        1 => "1.Runde",
        2 => "2.Runde",
        3 => "Achtelfinale",
        4 => "Viertelfinale",
        5 => "Halbfinale",
        6 => "Finale"
      }
    }

    def number_of_matchdays
      fail TeamsSizeError unless MATCHDAYS.keys.include? teams_size
      @number ||= MATCHDAYS[teams_size].size
    end

    def teams_size
      @teams_size ||= cup.teams.size
    end

    def start_date(number)
      SeasonUseCase::MatchdayStart.date_for(type: :cup,
                             number_all: number_of_matchdays,
                             competition_start: cup.start,
                             number: number,
                             level: cup.level)

    end

  end
end
