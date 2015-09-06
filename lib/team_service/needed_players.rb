module TeamService
  class NeededPlayers
    def initialize(team)
      @team = team
      @players = team.players
    end

    def need
      MAX_PLAYERS - players.size
    end

    private

    attr_reader :team, :players

  end
end
