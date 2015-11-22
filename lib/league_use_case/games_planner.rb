module LeagueUseCase
  class GamesPlanner
    def initialize(league: league)
      @league = league
    end

    def call

      calender.matchdays.each_with_index do |plan_matchday|

        matchday = MatchdayRepository::MatchdayCreator
          .create(plan_matchday.attributes)

        plan_matchday.games.each_with_index do |plan_game, index|
          GameRepository::GameCreator.with_appointment(
            date: plan_game.start,
            attributes: plan_game.attributes.merge(matchday_id: matchday.id))
        end

      end
    end

    private

    attr_reader :league

    def calender
      @calender ||= LeagueUseCase::GamePlanCalender.new(league: league)
    end

  end
end

