require 'team_repository/adapter'
require 'player_repository/adapter'

module ContractRepository

  class DoubleContractError < StandardError; end
  class WrongDateError < StandardError; end

  class Create
    def initialize(team:, player:, from:, to:)
      @team = team
      @player = player
      @from = from
      @to = to
      validate_no_existing_contract
      validate_from_before_to
    end

    def create
      Contract.create(
        organization: team.organization,
        human: player.human,
        from: from,
        to: to
      )
    end

    private

    attr_reader :team, :player, :from, :to

    def validate_no_existing_contract
      fail DoubleContractError unless existing_contracts.empty?
    end

    # TODO: move to ContractRepo
    def existing_contracts
      Contract
        .where(human: player.human)
        .where.not("contracts.to < ?", from)
    end

    def validate_from_before_to
      fail WrongDateError unless from <= to
    end
  end
end
