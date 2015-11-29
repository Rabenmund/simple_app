module CupUseCase

  class CupPlanner

    def initialize(season:, previous:, federation:)
      @season = season
      @previous = previous
      @federation = federation
    end

    def with_plan(plans)
      plans.each do |plan|
        CupRepository::CupCreator
          .new(season: season, previous: previous, federation: federation)
          .by_plan(plan)
      end

    end

    private

    attr_reader :season, :previous, :federation

  end
end
