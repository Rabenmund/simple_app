require 'end_of_year_service/retirements'
require 'end_of_year_service/prolongations'

module EndOfYearService
  class EndOfYear
    def initialize(year:)
      @year = year
    end

    def call
      EndOfYearService::Retirements.new(year: year).ask_for_decisions
      EndOfYearService::Prolongations.new(year: year).ask_for_decisions
      # GenerateNewPlayers for next year
    end

    private

    attr_reader :year
  end
end
