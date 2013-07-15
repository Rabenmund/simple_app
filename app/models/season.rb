# coding: utf-8

class Season < ActiveRecord::Base
  attr_accessible :name, :competition_ids
  has_many :competitions, dependent: :destroy
  has_many :matchdays, through: :competitions
  has_many :games, through: :competitions
  validates :name, presence: true, length: { maximum: 30 }

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