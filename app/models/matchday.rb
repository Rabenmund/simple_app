# coding: utf-8

class Matchday < ActiveRecord::Base
  attr_accessible :number
  belongs_to :competition
  has_many :games, dependent: :destroy
  validates :number, uniqueness: { scope: :competition_id }, presence: true, numericality: true

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