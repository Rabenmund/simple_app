module EndOfYearService
  class Prolongations
    def initialize(year:)
      @year = year
    end

    def ask_for_decisions
      # ask players with ending contracts whether they prolongate
    end

    private

    attr_reader :year
  end
end
