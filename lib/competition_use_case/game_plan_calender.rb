module CompetitionUseCase
  class TeamsSizeError < StandardError; end

  class GamePlanCalender

    PLAN = {34 =>[
      [[1,10],[2,11],[3,12],[4,13],[5,14],[6,15],[7,16],[8,17],[9,18]],
      [[18,8],[16,6],[15,5],[14,4],[13,3],[12,2],[11,1],[10,9],[17,7]],
      [[1,12],[2,13],[3,14],[4,15],[5,16],[6,17],[7,18],[10,11],[9,8]],
      [[18,6],[16,4],[15,3],[14,2],[13,1],[12,10],[11,9],[8,7],[17,5]],
      [[1,14],[2,15],[3,16],[4,17],[5,18],[6,8],[11,12],[10,13],[9,7]],
      [[18,4],[16,2],[15,1],[14,10],[13,11],[12,9],[7,6],[8,5],[17,3]],
      [[1,16],[2,17],[3,18],[4,8],[5,7],[12,13],[11,14],[10,15],[9,6]],
      [[18,2],[16,10],[15,11],[14,12],[13,9],[6,5],[7,4],[8,3],[17,1]],
      [[1,18],[2,8],[3,7],[4,6],[13,14],[12,15],[11,16],[10,17],[9,5]],
      [[18,10],[16,12],[15,13],[14,9],[5,4],[6,3],[7,2],[8,1],[17,11]],
      [[1,7],[2,6],[3,5],[14,15],[13,16],[12,17],[11,18],[10,8],[9,4]],
      [[18,12],[16,14],[15,9],[4,3],[5,2],[6,1],[7,10],[8,11],[17,13]],
      [[1,5],[2,4],[15,16],[14,17],[13,18],[12,8],[11,7],[10,6],[9,3]],
      [[18,14],[16,9],[3,2],[4,1],[5,10],[6,11],[7,12],[8,13],[17,15]],
      [[1,3],[2,9],[15,18],[14,8],[13,7],[12,6],[11,5],[10,4],[17,16]],
      [[18,16],[2,1],[3,10],[4,11],[5,12],[6,13],[7,14],[8,15],[9,17]],
      [[1,9],[16,8],[15,7],[14,6],[13,5],[12,4],[11,3],[10,2],[17,18]],
    ]}

    def initialize(competition:, type:)
      @competition = competition
      @type = type
      @competition_start = SeasonUseCase::CompetitionStart
        .date_for(year: competition.season.year)
    end

    def matchdays
      matchdays_enum = []
      PLAN[number_of_matchdays].each_with_index do |plan, number|

        matchday = PlanMatchday.new(
          type: type,
          start: matchday_start(number),
          number: number+1,
          plan: plan,
          level: competition.level
        )
        matchdays_enum << matchday
      end
      matchdays_enum
    end

    private
    attr_reader :competition, :competition_start, :type

    MATCHDAY_NUMBER = {18 => 34}

    def number_of_matchdays
      fail TeamsSizeError unless MATCHDAY_NUMBER.keys.include? teams_size
      MATCHDAY_NUMBER[competition.teams.size]
    end

    def teams_size
      @teams_size ||= competition.teams.size
    end

    def date
      DATES[number_of_matchdays]
    end

    def matchday_start(number)
      SeasonUseCase::MatchdayStart.date_for(
        type: type,
        number_all: number_of_matchdays,
        competition_start: competition_start,
        number: number,
        level: competition.level
        )
    end

    class PlanMatchday
      def initialize(start:, number:, plan:, type:, level:)
        @plan = plan
        @number = number
        @start = start
        @type = type
        @level = level
      end

      def attributes
        {
          number: number,
          start: start
        }
      end

      def games
        games_enum = []
        plan.each_with_index do |game_ids, index|
          game = PlanGame.new(
            home_id: game_ids[0],
            guest_id: game_ids[1],
            start: game_start(index)
          )
          games_enum << game
        end
        games_enum

      end

      private
      attr_reader :start, :number, :plan, :type, :level

      def game_start(index)
        SeasonUseCase::GameStart
          .date_time(type: type,
                     level: level,
                     matchday_start: start,
                     number: index)
      end
    end

    class PlanGame
      attr_reader :start

      def initialize(home_id:, guest_id:, start:)
        @home_id = home_id
        @guest_id = guest_id
        @start = start
      end

      def attributes
        { home_id: home_id, guest_id: guest_id }
      end

      private

      attr_reader :home_id, :guest_id

    end
  end
end

