module LeagueUseCase
  class FillUpWithTeams
    def initialize(league:, size:)
      @league = league
      @size = size
    end

    def random
      fill_up if teams_needed?
    end

    private

    attr_reader :league, :size

    def teams_needed?
      needed > 0
    end

    def needed
      @needed ||= size - league.teams.size
    end

    def fill_up
      fill_ups = TeamRepository::AvailableForLeague
        .new(league: league)
        .random(needed)

      fill_ups.each {|team| league.teams << team }
    end
  end
end
