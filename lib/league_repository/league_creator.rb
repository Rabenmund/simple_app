module LeagueRepository
  class NotEnoughTeamsError < StandardError; end

  class LeagueCreator
    def initialize(season:, previous:, federation:)
      @season = season
      @previous = previous
      @federation = federation
      @teams = []
      @relegators = []
      @promoters = []
      @candidates = []

    end

    def by_plan(league_plans)
      all_teams = []
      league_plans.each do |league_plan|
        previous_league = previous.leagues.find_by(name: league_plan.name)

        if previous_league
          candidates.concat  LeagueUseCase::Remainers
            .new(league: previous_league)
            .between(
               promoters_no: league_plan.promoters_no,
               relegators_no: league_plan.relegators_no
            )

            promoters.concat LeagueUseCase::Promoters
            .new(league: previous_league)
            .first(league_plan.promoters_no)

            relegators.concat LeagueUseCase::Relegators
            .new(league: previous_league)
            .last(league_plan.relegators_no)

          teams.concat relegators.slice!(0..-1)
          teams.concat promoters.slice!(0..-1)

          available_places = league_plan.teams_no - teams.size
          teams.concat candidates.slice!(0..(available_places - 1))
        end

        available_places = league_plan.teams_no - teams.size
        rest_teams = federation.teams - all_teams
        fail NotEnoughTeamsError if rest_teams.size < available_places

        available_places.times do
          teams << rest_teams.slice!(Random.rand(0...rest_teams.size)-1)
        end

        all_teams.concat teams

        create_league(
          level: league_plan.level,
          name: league_plan.name,
          teams: teams.slice!(0..-1)
        )

        relegators.concat candidates.slice!(0..-1)
      end
    end

    def create_league(level:, name:, teams:)
      league = League.create(
        season: season,
        federation: federation,
        start: season.start_date,
        name: name,
        level: level
      )
      teams.each {|team| league.teams << team }
      # TODO create matchdays and games and appointments
      league
    end

    private

    attr_reader :season, :previous, :federation
    attr_accessor :teams, :relegators, :promoters, :candidates

  end

end
