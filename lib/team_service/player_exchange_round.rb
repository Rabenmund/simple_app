require 'team_service/offers_for_needs'
require 'player_service/negotiate_offers'

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
      negotiate_players(player_ids.uniq)
    end

    private

    attr_reader :team_ids, :contract_start

    def offer_for_player_needs(team_id)
      TeamService::OffersForNeeds
        .new(team_id: team_id, contract_start: contract_start).players
    end

    def negotiate_players(ids)
      PlayerService::NegotiateOffers.new(ids).negotiate
    end
  end
end
