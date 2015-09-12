require 'offer_repository/adapter'
require 'offer_repository/accept'
require 'contract_repository/create'
require 'player_repository/close_all_offers'
require 'player_service/find_best_offer'

module PlayerService
  class NoBestOfferToContractError < StandardError; end

  class SelectOfferAndContract

    def initialize(id:)
      @id = id
      @offer = best_offer
    end

    def create_contract!
      # remove accepted and negotiated attributes
      # then delete all offers after create a new contract

      OfferRepository::Accept.new(id: offer.id).accept!

      PlayerRepository::CloseAllOffers.new(id: id).close

      ContractRepository::Create.new(
        player_id: id,
        team_id: offer.team_id,
        from: offer.start_date,
        to: offer.end_date
      ).create
    end

    private

    attr_reader :id, :offer

    def best_offer
      OfferRepository::Adapter.new(id: best_offer_id).offer
    end

    def best_offer_id
      PlayerService::FindBestOffer.new(id: id).offer ||
        fail(NoBestOfferToContractError)
    end
  end
end
