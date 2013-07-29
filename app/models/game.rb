# coding: utf-8

class Game < ActiveRecord::Base
  attr_accessible :home_id, :guest_id, :home_goals, :guest_goals, :home_points, :guest_points
  belongs_to :matchday
  has_one :league, through: :matchday
  validates_presence_of :home_id, :guest_id
  validates_numericality_of :home_id, :guest_id
  validates :home_goals, numericality: { only_integer: true }, allow_nil: true
  validates :guest_goals, numericality: { only_integer: true }, allow_nil: true
  validates :matchday, presence: true
  
  scope :not_finished, where("home_goals IS NULL OR guest_goals IS NULL")
  scope :finished, where("home_goals IS NOT NULL AND guest_goals IS NOT NULL")
  
  def finished?
    home_goals && guest_goals
  end
  
  def calculate_points
    return if !finished?
    if home_goals > guest_goals
      update_attributes(home_points: 3)
      update_attributes(guest_points: 0)
    end
    if home_goals < guest_goals
      update_attributes(home_points: 0)
      update_attributes(guest_points: 3)
    end
    if home_goals == guest_goals
      update_attributes(home_points: 1)
      update_attributes(guest_points: 1)
    end
  end
    
end