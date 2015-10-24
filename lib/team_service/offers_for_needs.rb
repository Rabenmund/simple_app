module TeamService
  class OffersForNeeds
    def initialize(team:, contract_start:)
      @team = team
      @date = contract_start
    end

    def players
      players = Array.new
      needed_team_structure.size.times do
        type = needed_team_structure.take_type!
        offer = best_player_offer_for type
        players << offer.player
      end
      players.uniq
    end

    def trainers
      # TODO somewhere later :-)
    end

    private

    attr_reader :team, :date

    def best_player_offer_for(type)
      TeamService::BestOffer
        .new(team: team, date: date)
        .offer_player(type: type)
    end

    def needed_team_structure
      @needs ||= TeamService::Needs
                  .new(team: team, date: date)
                  .team_structure
    end
  end
end
