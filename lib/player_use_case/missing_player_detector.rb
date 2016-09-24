module PlayerUseCase
  class MissingPlayerDetector

    def initialize(date:)
      @date = date
    end

    def generate_players
      missing_players.times do
        PlayerRepository::Factory.new(date: date).create
      end
    end

    private

    attr_reader :date

    def active_players
      @players ||= PlayerRepository::Active
                     .for_teams_at(teams: active_teams, date: date)
                     .count
    end

    def active_teams
      @teams ||= TeamRepository::Active.at(date)
    end

    def needed_players
      active_teams.size * 25
    end

    def missing_players
      needed_players - active_players
    end
  end
end
