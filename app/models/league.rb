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
  
end