class Point < ActiveRecord::Base

  belongs_to :game
  belongs_to :team
  belongs_to :league

  def self.board
    joins(:team).
    select("
      teams.name,
      sum(points) as points,
      sum(goals) as goals,
      sum(against) as against,
      sum(diff) as diff,
      sum(win) as win,
      sum(draw) as draw,
      sum(lost) as lost").
    group("teams.name").
    order("points DESC, diff DESC, goals DESC")
  end
end
