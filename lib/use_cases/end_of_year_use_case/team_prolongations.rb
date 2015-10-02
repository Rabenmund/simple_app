require "repositories/team_repository/ending_contracts.rb"
require "use_cases/team_use_case/player_prolongations.rb"

module EndOfYearUseCase
  module TeamProlongations
    class << self

      def decisions(date: date)
        ids = Array.new
        TeamRepository::EndingContracts.new(date: date).players.each do |team|
          ids.concat TeamUseCase::PlayerProlongations
            .new(team: team, date: date)
            .prolongate_players
        end
        ids
      end

    end
  end
end
