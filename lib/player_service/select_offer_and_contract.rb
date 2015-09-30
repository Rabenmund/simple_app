require 'offer_repository/adapter'
require 'offer_repository/accept'
require 'contract_repository/create'
require 'player_repository/close_all_offers'
require 'use_cases/player_use_case/find_best_offer'

module PlayerService
  class NoBestOfferToContractError < StandardError; end

  class SelectOfferAndContract

    def initialize(player:)
      @player = player
      @offer = best_offer
    end

    def create_contract!
      # remove accepted and negotiated attributes
      # then delete all offers after create a new contract

      OfferRepository::Accept.new(offer: offer).accept!

      PlayerRepository::CloseAllOffers.new(player: player).close

      ContractRepository::Create.new(
        player: player,
        team: offer.team,
        from: offer.start_date,
        to: offer.end_date
      ).create
    end

    private

    attr_reader :player, :offer

    def best_offer
      PlayerUseCase::FindBestOffer.new(player: player).find ||
        fail(NoBestOfferToContractError)
    end
  end
end
