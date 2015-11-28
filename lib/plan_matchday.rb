class PlanMatchday
  def initialize(start:, number:, plan:, type:, level:, invers: false)
    @plan = plan
    @number = number
    @start = start
    @type = type
    @level = level
    @invers = invers
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
      home_id = invers ? game_ids[1] : game_ids[0]
      guest_id = invers ? game_ids[0] : game_ids[1]
      game = PlanGame.new(
        home_id: home_id,
        guest_id: guest_id,
        start: game_start(index)
      )
      games_enum << game
    end
    games_enum

  end

  private
  attr_reader :start, :number, :plan, :type, :level, :invers

  def game_start(index)
    SeasonUseCase::GameStart
      .date_time(type: type,
    level: level,
    matchday_start: start,
    md_number: number,
    g_number: index)
  end
end

