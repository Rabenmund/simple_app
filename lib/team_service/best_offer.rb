module TeamService
  class BestOffer
    def initialize(team:, date:)
      @date = date
      @team = team
    end

    def offer_player(type:)
      OfferRepository::Create.create(
        player: best_player(type),
        team: team,
        reputation: team.reputation,
        start_date: date,
        end_date: end_date
      )
    end

    def offer_trainer
      # TODO future
    end

    private

    attr_reader :date, :team

    def best_player(type)
      PlayerRepository::BestPlayer.new(
        team: team,
        type: type,
        date: date,
        reputation: team.reputation
      ).best_player
    end

    def end_date
      PlayerUseCase::ContractEndDate.new(start_date: date).end_date
    end
  end
end
