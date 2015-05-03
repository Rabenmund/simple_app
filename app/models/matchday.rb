# coding: utf-8

class Matchday < ActiveRecord::Base

  belongs_to :competition
  has_many :games, -> { order "id ASC" }, dependent: :destroy
  has_one :draw # optional - cup matchdays only

  scope :unfinished,
    -> { joins(:games).where("games.finished = FALSE") }

  validates :number,
    uniqueness: { scope: :competition_id },
    presence: true, numericality: true
  validates :start,
    presence: true
  validates :competition,
    presence: true

  def has_games?
    games.any?
  end

  def finished?
    has_games? && games.not_finished.empty?
  end

  def can_be_drawed?
    draw && draw.can_be_performed?
  end

  def previous
    competition.matchdays.find_by(number: number-1)
  end

  def unfinished_previous_matchdays?
    previous_matchdays.unfinished.any?
  end

  private

  def previous_matchdays
    competition.matchdays.where("matchdays.number < ?", number)
  end

end
