class League < Competition
  # attr_accessible :name, :team_ids

  has_many :points, through: :games

  def finished?
    games.any? && games.not_finished.empty?
  end

  def started?
    games.any? && games.finished.any?
  end

  def not_started?
    !started?
  end

  def live_board
    # TODO vielleicht macht es später Sinn eine Abschlusstabelle in Form von 18 Sätzen seperat zu speichern, statt 608 point-sätze pro Liga. das kann dann über eine board methode

    board = teams.joins(:points).select("teams.name, sum(points) as team_points, sum(goals) as team_goals, sum(against) as team_against, sum(diff) as team_diff, sum(win) as team_win, sum(draw) as team_draw, sum(lost) as team_lost").group("teams.name").where("points.league_id = #{self.id}").order("team_points DESC, team_diff DESC, team_goals DESC")
  end

end
