module SeasonEventing
  class HalfTime < SeasonEvent

    def call
      SeasonUseCase::PlayerRetirements
        .new(year: season.end_date.year)
        .decisions
      SeasonUseCase::TeamProlongations
        .new(date: season.end_date)
        .decisions
      PlayerUseCase::AllDecideOffers
        .decisions
      # TODO: move that to season teardown before final negotiation round
      # TODO: move that under another namespace - not season related
      SeasonUseCase::ProduceMissingPlayers
        .at(season.end_date+1.day)
    end
  end
end
