# coding: utf-8

class Matchday < ActiveRecord::Base

  belongs_to :competition
  has_many :games, -> { order "id ASC" }, dependent: :destroy
  has_one :draw # optional - cup matchdays only

  validates :number,
    uniqueness: { scope: :competition_id },
    presence: true, numericality: true
  validates :start,
    presence: true
  validates :competition,
    presence: true

  def step
    games.each do |game|
      game.step
    end
  end

  def self.finished
    joins(:games).
      where(games: {finished: true}).
      uniq
  end

  def self.not_finished
    joins(:games).
      where(games: {finished: false}).
      uniq
  end

  def has_games?
    games.any?
  end

  def finished?
    has_games? && all_games_finished?
  end

  def can_be_drawed?
    draw && draw.can_be_performed?
  end

  # def started?
  #   has_games? && some_games_finished?
  # end

  # def not_started?
  #   !started?
  # end

  def previous
    competition.matchdays.find_by(number: number-1)
  end

  private

  def all_games_finished?
    games.not_finished.empty?
  end

  # def some_games_finished?
  #   games.finished.any?
  # end
end
