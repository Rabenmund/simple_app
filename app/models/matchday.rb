# coding: utf-8

class Matchday < ActiveRecord::Base
  attr_accessible :number
  belongs_to :league
  has_many :games, -> { order "id ASC" }, dependent: :destroy
  validates :number, uniqueness: { scope: :league_id }, presence: true, numericality: true
    
  def step
    games.each do |game|
      game.step
    end
  end 
  
  def self.finished
    joins(:games).where(games: {finished: true}).uniq
  end
  
  def self.not_finished
    joins(:games).where(games: {finished: false}).uniq
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