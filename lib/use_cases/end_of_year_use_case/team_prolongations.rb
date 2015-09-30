require "repositories/team_repository/ending_contracts.rb"
require "use_cases/team_use_case/player_prolongations.rb"

module EndOfYearUseCase
  module TeamProlongations
    class << self

      def decisions(date: date)
        ids = Array.new
        TeamRepository::EndingContracts.new(date: date).players.each do |team|
          ids.concat TeamUseCase::PlayerProlongations
            .new(team: team)
            .prolongate_at?(date)
        end
        ids
      end

    end
  end
end
