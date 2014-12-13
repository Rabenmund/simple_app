# coding: utf-8

class Matchday < ActiveRecord::Base
  attr_accessible :number, :start

  belongs_to :competition
  has_many :games, -> { order "id ASC" }, dependent: :destroy
  has_one :draw # optional - cup matchdays only

  validates :number, uniqueness: { scope: :competition_id }, presence: true, numericality: true
  validates :start, presence: true
  validates :competition, presence: true

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

  def previous
    competition.matchdays.find_by(number: number-1)
  end
end
