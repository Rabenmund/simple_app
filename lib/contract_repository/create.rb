require 'team_repository/adapter'
require 'player_repository/adapter'

module ContractRepository

  class DoubleContractError < StandardError; end
  class WrongDateError < StandardError; end

  class Create
    def initialize(team_id:, player_id:, from:, to:)
      @team_id = team_id
      @player_id = player_id
      @from = from
      @to = to
      validate_no_existing_contract
      validate_from_before_to
    end

    def create
      Contract.create(
        organization: organization(team_id),
        human: human(player_id),
        from: from,
        to: to
      )
    end

    private

    attr_reader :team_id, :player_id, :from, :to

    def validate_no_existing_contract
      fail DoubleContractError unless existing_contracts.empty?
    end

    def existing_contracts
      Contract
        .where(human_id: human(player_id).id)
        .where.not("contracts.to < ?", from)
    end

    def validate_from_before_to
      fail WrongDateError unless from <= to
    end

    def organization(team_id)
      TeamRepository::Adapter.new(id: team_id).organization
    end

    def human(player_id)
      @human ||= PlayerRepository::Adapter.new(id: player_id).human
    end
  end
end
