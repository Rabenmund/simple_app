# TODO: move that to another namespace - without season
module SeasonUseCase
  module ProduceMissingPlayers
    class << self
      def at(date)
        missing_players_at(date).times do
          PlayerRepository::Factory.create()
        end
      end

      private

      def active_players_at(date)
        PlayerRepository::Active.at(date).count
      end

      def active_teams_at(date)
        TeamRepository::Active.at(date).count
      end

      def needed_players_at(date)
        active_teams_at(date) * 25
      end

      def missing_players_at(date)
        needed_players_at(date) - active_players_at(date)
      end
    end
  end
end
