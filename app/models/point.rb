class Point < ActiveRecord::Base
  # attr_accessible :points, :team_id, :game_id, :league_id, :goals, :against, :diff, :win, :draw, :lost

  belongs_to :game
  belongs_to :team
  belongs_to :league

  def self.board
    joins(:team).
    select("
      teams.name,
      sum(points) as team_points,
      sum(goals) as team_goals,
      sum(against) as team_against,
      sum(diff) as team_diff,
      sum(win) as team_win,
      sum(draw) as team_draw,
      sum(lost) as team_lost").
    group("teams.name").
    order("team_points DESC, team_diff DESC, team_goals DESC")
  end
end
