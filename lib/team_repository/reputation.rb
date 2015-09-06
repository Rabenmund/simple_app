module TeamRepository
  class Reputation
    def initialize(id)
      @team = Team.find(id)
    end

    def reputation
      team.reputation
    end

    def reset!
      # TODO Here calculate and set a new reputation
      # called by a service
      #  - when a new season starts
      #  - whenever is needed
      reputation
    end

    private

    attr_reader :team
  end
end
