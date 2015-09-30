require 'repositories/team_repository/player_query'

module TeamUseCase
  class PlayerContractDecision

    def initialize(team:, player:, date:)
      # UseCase -> (Service[KlassMethods]) -> Repository (encapsulate Model) -> produces Entity (with business logic)
      @team = team
      @player = player
      @date = date
    end

    def decide!
      return true if better_than_team?
      return true if better_than_peers?
      false
    end

    private

    attr_reader :team, :player, :date

    def better_than_team?
      expected_player_strength > team_avg
    end

    def better_than_peers?
      expected_player_strength > type_avg * 1.05
    end

    def team_avg
      @team_avg ||= TeamRepository::PlayerQuery.new(team: team)
        .avg_at(date)
    end

    def type_avg
      @type_avg ||= TeamRepository::PlayerQuery.new(team: team)
        .type_avg_at(date, player.type)
    end

    def expected_player_strength
      @expected_player_strength ||= player.strength * (1 + youth_factor)
    end

    def youth_factor
      0.05 * youth
    end

    def youth
      25 - player.age
    end

  end
end
