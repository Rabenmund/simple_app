module SeasonUseCase
  class PlayerRetirements

    def initialize(year:)
      @year = year
    end

    def decisions
      retired_players = []

      old_players.each do |player|
        retired = retirement(player).retire?
        retired_players << player.id if retired
      end

      unwanted_players.each do |player|
        retirement(player).retire!
        retired_players << player.id
      end

      retired_players.uniq
    end

    private

    attr_reader :year

    def old_players
      PlayerRepository::OldPlayers
        .active_and_born_in(birthyear: year)
    end

    def unwanted_players
      PlayerRepository::UnwantedPlayers
        .without_contract_since(Date.new(year-2, 7, 1))
    end

    def retirement(player)
      PlayerUseCase::Retirement.new(player: player, year: year)
    end
  end
end
