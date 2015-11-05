module SeasonEventing
  class TearDown < SeasonEvent

    def call
      SeasonUseCase::TearUp
        .new(season: next_season)
        .invoke
    end

    private

    def next_season
      SeasonRepository::SeasonCreator
        .new(previous: season)
        .create_with_competitions
    end
  end
end
