module TeamRepository
  class Formation
    def initialize(id: id)
      @team = Team.find(id)
    end

    def formation
      {
        keepers: 1.5,
        defenders: 4,
        midfielders: 4,
        attackers: 2
      }
    end

    private

    attr_reader :team
  end
end
