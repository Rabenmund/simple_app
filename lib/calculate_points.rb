class CalculatePoints
  def initialize(game)
    @game = game
    @league = game.competition
  end

  def update!
    home_points, home_wdl, guest_points, guest_wdl = calculate_points
    update_points(
      @game.home_id, home_points,
      @game.home_goals,
      @game.guest_goals,
      home_wdl[0],
      home_wdl[1],
      home_wdl[2]
    )
    update_points(
      @game.guest_id,
      guest_points,
      @game.guest_goals,
      @game.home_goals,
      guest_wdl[0],
      guest_wdl[1],
      guest_wdl[2]
    )
  end

  def calculate_points
    return 1, [0,1,0], 1, [0,1,0] if @game.home_goals == @game.guest_goals
    return 3, [1,0,0], 0, [0,0,1] if @game.home_goals > @game.guest_goals
    return 0, [0,0,1], 3, [1,0,0]
  end

  def update_points(id, points, goals, against, win, draw, lost)
    attr = {
      points: points,
      goals: goals,
      against: against,
      diff: (goals-against),
      win: win,
      draw: draw,
      lost: lost,
      league_id: @league.id,
      level: @league.level,
      team_id: id
    }
    points = @game.points.find_by(team_id: id)
    if points
      points.update_attributes(attr)
    else
      @game.points.create(attr)
    end
  end

end
