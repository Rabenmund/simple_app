module TeamRepository
  class Players
    def initialize(id: id)
      @team = Team.find(id)
    end

    def size(type:, date:)
      team.players_at(date).send(type).size
    end

    private

    attr_reader :team

  end
end
