module CupUseCase

  class CupPlanner

    def initialize(season:, previous:, federation:)
      @season = season
      @previous = previous
      @federation = federation
    end

    def with_plan(plans)
      cups = []
      creator = CupRepository::CupCreator
          .new(season: season, previous: previous, federation: federation)

      plans.each do |plan|
          cups << creator.by_plan(plan)
      end

      return cups
    end

    private

    attr_reader :season, :previous, :federation

  end
end
