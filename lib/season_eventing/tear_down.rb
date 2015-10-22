module SeasonEventing
  class TearDown < SeasonEvent

    def call
      SeasonUseCase::TearUp.new(season: next_season).invoke
    end

    private

    def next_season
      SeasonRepository::NextSeasonCreator.new(season: season).create
    end
  end
end
