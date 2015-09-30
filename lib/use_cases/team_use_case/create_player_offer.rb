require 'use_cases/player_use_case/contract_end_date'
require 'repositories/offer_repository/create'

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
