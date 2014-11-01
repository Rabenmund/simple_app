class CalculatePoints

  def self.calculate(game)
    return unless game.finished?
    if game.home_goals > game.guest_goals
      self.update_or_create_points(game, game.home_id, 3, game.home_goals, game.guest_goals)
      self.update_or_create_points(game, game.guest_id, 0, game.guest_goals, game.home_goals)
    end
    if game.home_goals < game.guest_goals
      self.update_or_create_points(game, game.home_id, 0, game.home_goals, game.guest_goals)
      self.update_or_create_points(game, game.guest_id, 3, game.guest_goals, game.home_goals)
    end
    if game.home_goals == game.guest_goals
      self.update_or_create_points(game, game.home_id, 1, game.home_goals, game.guest_goals)
      self.update_or_create_points(game, game.guest_id, 1, game.guest_goals, game.home_goals)
    end
  end

  private

  def self.update_or_create_points(game, team_id, points, goals, against)
    p = game.points.find_by_team_id(team_id)
    win, draw, lost = self.set_wdl_count(points)
    diff = goals - against
    if p
      p.update_attributes!(points: points, goals: goals, against: against, diff: diff, win: win, draw: draw, lost: lost)
    else
      game.points.create(league_id: game.competition.id, team_id: team_id, points: points, goals: goals, against: against, diff: diff, win: win, draw: draw, lost: lost )
    end
  end

  def self.set_wdl_count(points)
    win, draw, lost = 0,0,0
    case points
    when 3
      win = 1
    when 1
      draw = 1
    when 0
      lost = 1
    end
    return win, draw, lost
  end

end
