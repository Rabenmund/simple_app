require 'team_service/offers_for_needs'

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
        .new(id: team_id, contract_start: contract_start).players
    end

    def create_contract_for(player_id)
      # TODO: do not use Player model here
      # inject objects to class
      PlayerUseCase::DecideOffers
        .new(player: Player.find(player_id))
        .accept_best_offer
    end
  end
end
