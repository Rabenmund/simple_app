# coding: utf-8

class Matchday < ActiveRecord::Base
  attr_accessible :number
  belongs_to :league
  has_many :games, dependent: :destroy
  validates :number, uniqueness: { scope: :league_id }, presence: true, numericality: true
  
  def self.finished
    joins(:games).where("home_goals IS NOT NULL AND guest_goals IS NOT NULL").uniq
  end
  
  def self.not_finished
    joins(:games).where("home_goals IS NULL OR guest_goals IS NULL").uniq
  end

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