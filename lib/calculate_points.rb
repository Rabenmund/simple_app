class CalculatePoints
  
  def self.calculate(game)
    return unless game.finished?
    if game.home_goals > game.guest_goals
      self.update_or_create_points(game, game.home_id, 3)
    end
    if game.home_goals < game.guest_goals
      self.update_or_create_points(game, game.guest_id, 3)
    end
    if game.home_goals == game.guest_goals
      self.update_or_create_points(game, game.home_id, 1)
      self.update_or_create_points(game, game.guest_id, 1)
    end
  end
  
  private
  
  def self.update_or_create_points(game, team_id, points)
    p = game.points.find_by_team_id(team_id)
    if p
      p.update_attributes!(points: points)
    else
      game.points.create(team_id: team_id, points: points)
    end
  end
  
end