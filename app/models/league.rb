class League < ActiveRecord::Base
  attr_accessible :name, :team_ids

  validates :name, presence: true

  has_and_belongs_to_many :teams
  has_many :matchdays, dependent: :destroy, order: "number ASC"
  has_many :games, through: :matchdays
  has_many :points
  
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
    # vielleicht macht es später Sinn eine Abschlusstabelle in Form von 18 Sätzen seperat zu speichern, statt 608 point-sätze pro Liga. das kann dann über eine board methode
    
    board = teams.joins(:points).select("teams.name, sum(points) as team_points, sum(goals) as team_goals, sum(against) as team_against, sum(win) as team_win, sum(draw) as team_draw, sum(lost) as team_lost").group("teams.name").order("team_points DESC, team_goals DESC, team_against ASC")
    
#    teams.joins(:home_games).select("teams.name, sum(home_points) as h_points, sum(guest_points) as g_points as points").group("teams.name").order("points DESC")
  end
  
end