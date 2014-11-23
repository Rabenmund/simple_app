# coding: utf-8

class Game < ActiveRecord::Base

  include Appointable

  belongs_to :matchday
  has_one :competition, through: :matchday
  has_one :season, through: :competition

  belongs_to :home, class_name: "Team"
  belongs_to :guest, class_name: "Team"

  has_many :points

  validates_presence_of :home_id, :guest_id
  validates :matchday, presence: true

  scope :not_finished, -> { where(finished: false) }
  scope :finished, -> { where(finished: true) }

  def finish!
    return false unless home_goals && guest_goals
    CalculatePoints.new(self).update!
    appointment.destroy if appointment
    update_attributes(finished: true)
  end

  def perform!
    return false if finished?
    update_attributes(performed_at: performed_at+1.minute)

  end

  def step
    return if finished
    update_attributes(home_goals: 0, guest_goals: 0) unless home_goals || guest_goals
    perform_event
    update_second
    save
    if to_be_finished?
      finish!
    end
  end

  private

  def start_date
    matchday.start
  end

  def perform_event
    if Random.new.rand(30) == 1
      if Random.new.rand(3) == 1
        self.guest_goals += 1
      else
        self.home_goals += 1
      end
    end
  end

  def update_second
    self.second += 60
  end

  def to_be_finished?
    second >= 5400
  end

end
