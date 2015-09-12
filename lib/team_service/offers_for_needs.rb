require "team_service/needs"
require "team_service/best_offer"

module TeamService
  class OffersForNeeds
    def initialize(id:, contract_start:)
      @id = id
      @date = contract_start
    end

    def players
      player_ids = Array.new
      needed_team_structure.size.times do
        type = needed_team_structure.take_type!
        offer = best_player_offer_for type
        player_ids << offer.player_id
      end
      player_ids.uniq
    end

    def trainers
      # TODO somewhere later :-)
    end

    private

    attr_reader :id, :date

    def best_player_offer_for(type)
      TeamService::BestOffer
        .new(id: id, date: date)
        .offer_player(type: type)
    end

    def needed_team_structure
      @needs ||= TeamService::Needs
                  .new(id: id, date: date)
                  .team_structure
    end
  end
end
