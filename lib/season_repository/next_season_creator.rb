module SeasonRepository
  class NextSeasonCreator
    def initialize(season:)
      @season = season
    end

    def create
      next_season unless season.next_one
    end

    private

    attr_reader :season

    def next_season
      @next ||= Season.create(
        year: season.year + 1,
        start_date: DateTime.new((season.year), 7, 1),
        end_date: DateTime.new((season.year + 1), 6, 30)
      )
    end
  end
end
