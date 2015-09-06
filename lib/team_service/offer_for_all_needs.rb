require "team_adapter/needs"
require "team_service/best_offer"

module TeamService
  class OfferForAllNeeds
    def initialize(team:, contract_start:)
      @team = team
      @contract_start = contract_start
    end

    def offer
      player_ids = Array.new
      needs.each_key do |need|
        needs[need].times do
          player = best_offer_for need
          player_ids << player.id
        end
      end
      player_ids.uniq
    end

    private

    attr_reader :team, :contract_start

    def best_offer_for(need)
      TeamService::BestOffer
        .new(team: team,
             players: send(need),
             contract_start: contract_start)
        .offer
    end

    def needs
      @needs ||= Hash.new.merge(
        TeamAdapter::Needs
        .new(id: team.id, date: contract_start)
        .players
      )
    end

    def players
      @players ||= Player.contractable_at(contract_start)
    end

    def keepers
      @keepers ||= players.keepers
    end

    def defenders
      @defenders ||= players.defenders
    end

    def midfielders
      @midfielders ||= players.midfielders
    end

    def attackers
      @attackers ||= players.attackers
    end
  end
end
