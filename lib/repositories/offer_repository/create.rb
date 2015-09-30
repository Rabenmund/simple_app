module OfferRepository
  module Create
    class << self
      def create(
        player:, team:, reputation:, start_date:, end_date:,
        negotiated: false,
        accepted: false
      )
        Offer.create(
          player_id: player.id,
          team_id: team.id,
          reputation: reputation,
          start_date: start_date,
          end_date: end_date,
          negotiated: negotiated,
          accepted: accepted
        )
      end
    end
  end
end
