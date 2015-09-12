module EndOfYearService
  class Retirements
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
      PlayerRepository::Age.new(year: year).old
    end

    def retire?(id)
      PlayerService::Retirement.new(id: id, year: year).retire?
    end
  end
end
