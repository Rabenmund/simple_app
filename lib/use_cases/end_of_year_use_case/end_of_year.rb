require 'use_cases/end_of_year_use_case/player_retirements'
require 'use_cases/end_of_year_use_case/team_prolongations'

module EndOfYearUseCase
  module EndOfYear
    class << self

      def call(year: year)
        PlayerRetirements.new(year: year).decisions
        TeamProlongations.new(date: end_date(year)).decisions
        # GenerateNewPlayers for next year
      end

      private

      def end_date(year)
        Date.new((year + 1),6,30)
      end
    end
  end
end
