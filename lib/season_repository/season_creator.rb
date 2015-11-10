module SeasonRepository
  class SeasonAlreadyCreatedError < StandardError; end

  class SeasonCreator
    def initialize(previous:)
      @previous = previous
    end

    def create_with_competitions
      fail SeasonAlreadyCreatedError if previous.next_one
      previous.federations.each do |federation|
        LeagueUseCase::LeaguePlanner
          .new(season: season, previous: previous, federation: federation)
          .by_plan(federation.competition_plan.leagues)
        CupRepository::CupCreator
          .new(season: season, previous: previous, federation: federation)
          .by_plan(federation.competition_plan.cups)
      end
      season
    end

    private

    attr_reader :previous

    def season
      @new ||= create_season
    end

    def create_season
      season = Season.create(
        year: previous.year + 1,
        start_date: DateTime.new((previous.year), 7, 1),
        end_date: DateTime.new((previous.year + 1), 6, 30)
      )
      previous.federations.each do |federation|
        season.federations << federation
      end
      season
    end
  end
end
