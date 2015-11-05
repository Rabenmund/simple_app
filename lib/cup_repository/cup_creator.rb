module CupRepository
  class CupCreator
    def initialize(season:, previous:)
      @season = season
      @previous = previous
    end

    def by_plan(plan)

    end

    private

    attr_reader :season, :previous
  end
end

