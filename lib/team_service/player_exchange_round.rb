module TeamService
  class PlayerExchangeRound

    def initialize(teams:, contract_start:)
      @teams = teams
      @contract_start = contract_start
    end

    def execute
      players = Array.new

      teams.each do |team|
        players.concat offer_for_player_needs(team)
      end

      players.uniq.each do |player|
        create_contract_for player
      end
    end

    private

    attr_reader :teams, :contract_start

    def offer_for_player_needs(team)
      TeamService::OffersForNeeds
        .new(team: team, contract_start: contract_start).players
    end

    def create_contract_for(player)
      PlayerUseCase::DecideOffers
        .new(player: player)
        .accept_best_offer
    end
  end
end
