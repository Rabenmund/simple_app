module EndOfYearService
  class Retirements

    YEARS_TO_BE_OLD = 30

    def initialize(year:)
      @year = year
    end

    def ask_for_decisions
      old_players.each do |player|
        retired_players.concat player if retire?(player)
      end
    end

    private

    attr_reader :year

    def old_players
      PlayerRepository::Age
        .old_players(birthyear: birthyear)
    end

    def retire?(id)
      PlayerService::Retirement
        .new(id: id)
        .retire?(birthyear: birthyear)
    end

    def birthyear
      year - YEARS_TO_BE_OLD
    end
  end
end
