# coding: utf-8

class Matchday < ActiveRecord::Base

  belongs_to :competition
  has_many :games, dependent: :destroy
  has_many :appointments, through: :games
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

  # def next_appointable
  #   next_appointment.try(:appointable)
  # end

  # def next_appointment
  #   @appointment ||= appointments.
  #     order(appointed_at: :asc).
  #     first
  # end

  # def current_date_time
  #   next_appointment.
  #     try(:appointed_at) ||
  #   games.
  #     order(performed_at: :desc, second: :desc).
  #     first.try(:current_date_time) ||
  #   start
  # end

  def perform!
    # TODO: find a better way to perform a matchday...:-)
    # next_appointable.perform!
  end

  def has_games?
    games.any?
  end

  def finished?
    has_games? && games.not_finished.empty?
  end

  def can_be_performed?
    !finished?
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

  def has_board?
    competition.respond_to? :board
  end

  private

  def previous_matchdays
    competition.matchdays.where("matchdays.number < ?", number)
  end

end
