module LeagueUseCase
  class GamesPlanner
    def initialize(league:)
      @league = league
    end

    def call
      calender.matchdays.each_with_index do |plan_matchday|

        matchday = MatchdayRepository::MatchdayCreator
          .create(plan_matchday
                    .attributes
                    .merge({competition_id: league.id}))

        plan_matchday.games.each_with_index do |plan_game, index|
          attributes = plan_game.attributes.merge(matchday_id: matchday.id)
          GameRepository::GameCreator.create(
            date: plan_game.start,
            attributes: attributes
          )
        end

      end
    end

    private

    attr_reader :league

    def calender
      @calender ||= LeagueUseCase::GamePlanCalender
        .new(league: league)
    end

  end
end

