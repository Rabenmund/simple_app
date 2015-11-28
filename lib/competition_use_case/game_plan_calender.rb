module CompetitionUseCase
  class TeamsSizeError < StandardError; end

  class GamePlanCalender

    PLAN = {34 =>[
      [[1,10],[2,11],[3,12],[4,13],[5,14],[6,15],[7,16],[8,17],[9,18]],
      [[18,8],[16,6],[15,5],[14,4],[13,3],[12,2],[11,1],[10,9],[17,7]],
      [[2,13],[3,14],[4,15],[5,16],[6,17],[7,18],[10,11],[9,8],[1,12]],
      [[11,9],[15,3],[14,2],[13,1],[12,10],[8,7],[17,5],[18,6],[16,4]],
      [[3,16],[4,17],[5,18],[6,8],[11,12],[10,13],[9,7],[1,14],[2,15]],
      [[15,1],[14,10],[13,11],[12,9],[7,6],[8,5],[17,3],[18,4],[16,2]],
      [[4,8],[5,7],[12,13],[11,14],[10,15],[9,6],[1,16],[2,17],[3,18]],
      [[14,12],[13,9],[6,5],[7,4],[8,3],[17,1],[18,2],[16,10],[15,11]],
      [[13,14],[12,15],[11,16],[10,17],[9,5],[1,18],[2,8],[3,7],[4,6]],
      [[5,4],[6,3],[7,2],[8,1],[17,11],[18,10],[16,12],[15,13],[14,9]],
      [[12,17],[11,18],[10,8],[9,4],[1,7],[2,6],[3,5],[14,15],[13,16]],
      [[6,1],[7,10],[8,11],[17,13],[18,12],[16,14],[15,9],[4,3],[5,2]],
      [[11,7],[10,6],[9,3],[1,5],[2,4],[15,16],[14,17],[13,18],[12,8]],
      [[16,9],[6,11],[7,12],[8,13],[17,15],[18,14],[3,2],[4,1],[5,10]],
      [[10,4],[17,16],[1,3],[2,9],[15,18],[14,8],[13,7],[12,6],[11,5]],
      [[7,14],[8,15],[9,17],[18,16],[2,1],[3,10],[4,11],[5,12],[6,13]],
      [[17,18],[1,9],[16,8],[15,7],[14,6],[13,5],[12,4],[11,3],[10,2]],
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

        # Hinrunde
        matchday = PlanMatchday.new(
          type: type,
          start: matchday_start(number+1),
          number: number+1,
          plan: plan,
          level: competition.level
        )
        matchdays_enum << matchday

        # Rueckrunde
        matchday = PlanMatchday.new(
          type: type,
          start: matchday_start(number+18),
          number: number+18,
          plan: plan,
          level: competition.level,
          invers: true
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

  end

end

