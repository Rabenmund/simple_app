module TeamRepository
  class Players
    def initialize(id: id)
      @team = Team.find(id)
    end

    def size(type:, date:)
      team.players_at(date).send(type).size
    end

    def all_types_size(date:)
      team.players_at(date).size
    end

    private

    attr_reader :team

  end
end
