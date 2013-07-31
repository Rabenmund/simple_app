class League < ActiveRecord::Base
  attr_accessible :name, :team_ids

  validates :name, presence: true

  has_and_belongs_to_many :teams
  has_many :matchdays, dependent: :destroy, order: "number ASC"
  has_many :games, through: :matchdays
  
  def finished?
    games.any? && games.not_finished.empty?
  end
  
  def started?
    games.any? && games.finished.any?
  end
  
  def not_started?
    !started?
  end
  
  def board
    # es braucht eine seperate tabelle teams <-> games mit points
    
#    teams.joins(:home_games).select("teams.name, sum(home_points) as h_points, sum(guest_points) as g_points as points").group("teams.name").order("points DESC")
  end
  
end