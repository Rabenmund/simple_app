module CupUseCase
  class NotEnoughTeamsError < StandardError; end

  class CupPlanner

    def initialize(season:, previous:, federation:)
      @season = season
      @previous = previous
      @federation = federation
    end

    def with_plan(plan)
      plan.each do |cup_plan|
        cup = Cup.create(
            level: cup_plan.level,
            name: cup_plan.name,
            season: season,
            federation: federation,
            start: season.start_date
        )
        adder = TeamAdder.new(teamable: cup)
        cup_plan.qualified.leagues.each do |level, size|
          adder.from_leagues(previous, level, size)
        end
      end

    end

    private

    attr_reader :season, :previous, :federation

  end
end
