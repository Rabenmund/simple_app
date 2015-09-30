require 'repositories/player_repository/ending_contracts'
require 'use_cases/team_use_case/player_contract_decision'
require 'use_cases/team_use_case/create_player_offer'

module TeamUseCase
  class PlayerProlongations

    def initialize(team:, date:)
      @team = team
      @date = date
    end

    def prolongate_players
      prolongated = Array.new
      players_with_ending_contracts_at(date).each do |player|
        if contract_prolongated?(player)
          TeamUseCase::CreatePlayerOffer
            .at(team: team, player: player, date: date)
          prolongated << player.id
        end
      end
      return prolongated
    end

    private

    attr_reader :team, :date

    def contract_prolongated?(player)
      TeamUseCase::PlayerContractDecision.new(
        team: team,
        player: player,
        date: date
      ).decide!
    end

    def players_with_ending_contracts_at(date)
      PlayerRepository::EndingContracts.new(date: date).for_team(team)
    end
  end
end
