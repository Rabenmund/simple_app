module LeagueService
  class PlayerNegotiationRound

    def initialize(teams:, contract_start:)
      @teams = teams
      @contract_start = contract_start
    end

    def execute
      player_ids = Array.new
      teams.each {|team| player_ids.concat offer_for_all_needs(team) }
      negotiate_players(player_ids.uniq)
    end

    private

    attr_reader :teams, :contract_start

    def offer_for_all_needs(team)
      TeamService::OfferForAllNeeds
        .new(team: team, contract_start: contract_start).offer
    end

    def negotiate_players(ids)
      PlayerService::NegotiateOffers.new(ids).negotiate
    end
  end
end
