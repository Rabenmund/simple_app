module TeamRepository
  class Adapter
    attr_reader :team

    def initialize(id:)
      @team = Team.find(id)
    end

    def organization
      team.organization
    end
  end
end
