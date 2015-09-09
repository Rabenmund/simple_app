require 'team_service/offers_for_needs'
require 'player_service/select_offer_and_contract'

module TeamService
  class PlayerExchangeRound

    def initialize(team_ids:, contract_start:)
      @team_ids = team_ids
      @contract_start = contract_start
    end

    def execute
      player_ids = Array.new

      team_ids.each do |team_id|
        player_ids.concat offer_for_player_needs(team_id)
      end

      player_ids.uniq.each do |player_id|
        create_contract_for player_id
      end
    end

    private

    attr_reader :team_ids, :contract_start

    def offer_for_player_needs(team_id)
      TeamService::OffersForNeeds
        .new(team_id: team_id, contract_start: contract_start).players
    end

    def create_contract_for(player_id)
      PlayerService::SelectOfferAndContract.new(id: player_id).create_contract!
    end
  end
end
