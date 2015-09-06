module TeamQuery
  class Players
    def initialize(id: id)
      @team = Team.find(id)
    end

    def size(type:, date:)
      send(type, date).size
    end

    private

    attr_reader :team

    # TODO use date here to get the right ones

    def players
      team.players
    end

    def keepers(date)
      team.keepers
    end

    def defenders(date)
      team.defenders
    end

    def midfielders(date)
      team.midfielders
    end

    def attackers(date)
      team.attackers
    end
  end
end
