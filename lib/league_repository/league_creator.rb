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
          candidates.concat  LeagueRepository::Remainers
            .new(league: previous_league)
            .between(
               promoters_no: league_plan.promoters_no,
               relegators_no: league_plan.relegators_no
            )

            promoters.concat LeagueRepository::Promoters
            .new(league: previous_league)
            .first(league_plan.promoters_no)

            relegators.concat LeagueRepository::Relegators
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
      league
    end

    private

    attr_reader :season, :previous, :federation
    attr_accessor :teams, :relegators, :promoters, :candidates

  end

  class Ranking
    def initialize(league:)
      @league = league
    end

    def first(no = 1)
      league
        .teams
        .joins(:results)
        .where("results.league_id = #{self.id}")
        .first(no)
        .order("results.rank")

    end

    def last(no = 1)
      league
        .teams
        .joins(:results)
        .where("results.league_id = #{self.id}")
        .last(no)
        .order("results.rank")

    end

    def between(from, to)
      league
        .teams
        .joins(:results)
        .where("results.league_id = #{self.id}")
        .where("results.rank" => from..to)
        .order("results.rank")

    end

    private

    attr_reader :league

  end

  class Remainers
    def initialize(league:)
      @league = league
    end

    def between(promoters_no:, relegators_no:)
      LeagueRepository::Ranking
        .new(league: league)
        .from_to(promoters_no, relegators_no)
    end

    private

    attr_reader :league

  end

  class Promoters
    class SubleaguesDoNotMatchPromotersNumberError < StandardError; end

    def initialize(league:)
      @league = league
    end

    def first(promoters_no)
      subleagues = LeagueRepository::Subleagues
        .find_all_for league

      # funktioniert nur mit einem Aufsteiger pro subleague
      unless promoters_no == subleagues.size
        fail SubleaguesDoNotMatchPromotersNumberError
      end

      # array/hash/enum.inject(initialize memo) {|memo, v/k,v/v} returns memo
      subleagues.inject([]) do |memo, subleague|
        memo << LeagueRepository::Ranking
          .new(league: subleague)
          .first
      end
    end

    private

    attr_reader :league

  end

  class Relegators
    def initialize(league:)
      @league = league
    end

    def last(relegators_no)
      superleague = LeagueRepository::Superleague
        .find_for league

      LeagueRepository::Ranking
        .new(league: superleague)
        .last(relegators_no)
    end

    private

    attr_reader :league

  end

  module Subleague
    class << self
      def find_all_for(league)
        league
          .season
          .leagues
          .where(level: (league.level + 1))
      end
    end
  end

  module Superleague
    class << self
      def find_for(league)
        league
          .season
          .leagues
          .find_by(level: (league.level - 1))
      end
    end
  end

end

module FederationUseCase
  class FreeTeams
    def initialize(federation:)
      @federation = federation
    end

    def random_in_season(season)

    end

    def all_in_season
      federation.teams
        .teams
        .where
    end

    private

    attr_reader :federation
  end
end
