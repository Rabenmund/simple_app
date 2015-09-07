require "team_service/needs"
require "team_service/best_offer"

module TeamService
  class OffersForNeeds
    def initialize(team_id:, contract_start:)
      @team_id = team_id
      @date = contract_start
    end

    def players
      player_ids = Array.new
      needs_players.each_key do |type|
        puts "TS::OFN: type: #{type.inspect}"
        needs_players[type].times do
          offer = best_player_offer_for singularized_sym(type)
          player_ids << offer.player_id
        end
      end
      player_ids.uniq
    end

    def trainers
      # TODO somewhere later :-)
    end

    private

    attr_reader :team_id, :date

    def best_player_offer_for(type)
      TeamService::BestOffer
        .new(id: team_id, date: date)
        .offer_player(type: type)
    end

    def needs_players
      @needs ||= Hash.new.merge(
        TeamService::Needs
        .new(id: team_id, date: date)
        .players
      )
    end

    def singularized_sym(type)
      type.to_s.singularize.to_sym
    end
  end
end
