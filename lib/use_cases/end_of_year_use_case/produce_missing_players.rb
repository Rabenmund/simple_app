module EndOfYearUseCase
  module ProduceMissingPlayers
    class << self
      def at(date)
        missing_players_at(date).times do
          PlayerRepository::Factory.create()
        end
      end

      private

      def active_players_at(date)
        PlayerRepository::ActiveCounter.at(date)
      end

      def active_teams_at(date)
        TeamRepository::Active.count_at(date)
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
