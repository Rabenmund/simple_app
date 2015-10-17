module TeamUseCase
  module CreatePlayerOffer
    class << self

      def at(team:, player:, date:)
        end_date = PlayerUseCase::ContractEndDate
          .call(start_date: date, player: player)

        OfferRepository::Create.create(
          player: player,
          team: team,
          reputation: team.reputation,
          start_date: date,
          end_date: end_date
        )
      end

    end
  end
end
