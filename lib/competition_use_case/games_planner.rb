module CompetitionUseCase
  class GamesPlanner
    def initialize(competition:, type:)
      @competition = competition
      @type = type
    end

    def call
      calender.matchdays.each_with_index do |plan_matchday|

        matchday = MatchdayRepository::MatchdayCreator
          .create(plan_matchday
                    .attributes
                    .merge({competition_id: competition.id}))

        plan_matchday.games.each_with_index do |plan_game, index|
          GameRepository::GameCreator.with_appointment(
            date: plan_game.start,
            attributes: plan_game.attributes.merge(matchday_id: matchday.id))
        end

      end
    end

    private

    attr_reader :competition, :type

    def calender
      @calender ||= CompetitionUseCase::GamePlanCalender
        .new(competition: competition, type: type)
    end

  end
end

