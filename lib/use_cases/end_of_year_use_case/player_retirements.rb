require 'repositories/player_repository/old_players'
require 'use_cases/player_use_case/retirement'

module EndOfYearUseCase
  class PlayerRetirements

    def initialize(year:)
      @year = year
    end

    def decisions
      retired_players = []
      old_players.each do |player|
        retired_players << player.id if retire?(player)
      end
      retired_players
    end

    private

    attr_reader :year

    def old_players
      PlayerRepository::OldPlayers
        .find_at(birthyear: year)
    end

    def retire?(player)
      PlayerUseCase::Retirement
        .new(player: player, year: year)
        .retire?
    end
  end
end
