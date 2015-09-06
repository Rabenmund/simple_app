module TeamService
  class BestOffer
    def initialize(id:, type:, date:)
      @reputation = TeamRepository::Reputation.new(id).reputation
      @date = date
      @type = type
    end

    def offer
      OfferRepository::Create.create(
        player: best_player,
        team_id: id,
        reputation: reputation,
        start_date: date,
        end_date: end_date
      )
    end

    private

    attr_reader :reputation, :type, :date

    def best_player
      @best_player ||= PlayerRepository::BestPlayer.new(
        team_id: id, type: type, date: date, reputation: reputation
      ).best_player
    end

    def end_date
      TeamService::EndDate.new(start_date: date).end_date
    end
  end
end
