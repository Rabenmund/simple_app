# coding: utf-8

class Game < ActiveRecord::Base

  include Appointable

  END_FIRST = 2700
  START_SECOND = 3600
  END_SECOND = 6300
  START_THIRD = 7200
  END_THIRD = 8100
  START_FOURTH = 8400
  END_FOURTH = 9300
  START_SHOOT_OUT = 9600

  belongs_to :matchday
  has_one :competition, through: :matchday
  has_one :season, through: :competition

  belongs_to :home, class_name: "Team"
  belongs_to :guest, class_name: "Team"
  has_many :lineups
  has_many :points

  validates_presence_of :home_id, :guest_id
  validates :matchday, presence: true

  scope :not_finished, -> { where(finished: false) }
  scope :finished, -> { where(finished: true) }
  scope :ordered, -> { order(:id) }
  scope :ordered_reverse, -> { order(id: :desc) }

  def home_lineup
    lineups.find_by(team_id: home_id)
  end

  def guest_lineup
    lineups.find_by(team_id: guest_id)
  end

  def finish!
    return false unless home_goals && guest_goals
    return true if finished?
    self.finished = true
    save
    appointment.destroy if appointment
    calculate_points
  end

  def start
    @start = Time.now
  end

  def perform!
    return false if finished?
    tearup unless started?
    # puts "g1: #{Time.now-start}"
    appointment.update_attributes(appointed_at: appointment.appointed_at+60)
    # puts "g1.5: #{Time.now-start}"
    update_attributes(second: second+60)
    case second
    when between_first_and_second_half?
      # puts "g2: #{Time.now-start}"
      finish_first_half! if finish_first_half?
      game_event unless first_half_finished?
    when between_second_and_third_part?
      # puts "g2.1: #{Time.now-start}"
      finish_second_half! if finish_second_half?
      game_event unless second_half_finished?
    when between_third_and_fourth_part?
      finish_third_part! if finish_third_part?
      game_event unless third_part_finished?
    when between_fourth_part_and_shoot_out?
      finish_fourth_part! if finish_fourth_part?
      game_event unless fourth_part_finished?
    else
      if second > START_SHOOT_OUT
        # puts "g2.21: #{Time.now-start}"
        shoot_out_event!
        finish! if shoot_out_iteration_finished? && decision_done?
      else
        # puts "g3: #{Time.now-start}"
        game_event
        # puts "g4: #{Time.now-start}"
      end
    end
    # puts "g7: #{Time.now-start}"
    true
  end

  def current_date_time
    performed_at + second
  end

  def started?
    second > 0
  end

  private

  def tearup
    lineups.create(team_id: home_id) unless home_lineup
    lineups.create(team_id: guest_id) unless guest_lineup
    home_lineup.tearup
    guest_lineup.tearup
  end

  def calculate_points
    # puts "g5: #{Time.now-start}"
    CalculatePoints.new(self).update! if matchday.has_board?
    # puts "g6: #{Time.now-start}"
  end

  def game_event
    # puts "g2.3: #{Time.now-start}"
    if GameEventer.new(self).perform!
      calculate_points
    end
  end

  def shoot_out_event!
    ShootOutEventer.new(self).perform!
  end

  def between_first_and_second_half?
    END_FIRST..START_SECOND
  end

  def between_second_and_third_part?
    END_SECOND..START_THIRD
  end

  def between_third_and_fourth_part?
    END_THIRD..START_FOURTH
  end

  def between_fourth_part_and_shoot_out?
    END_FOURTH..START_SHOOT_OUT
  end

  def shoot_out_iteration_finished?
    shots % 5 == 0
  end

  def start_date
    matchday.start
  end

  def finish_first_half?
    return false if first_half_finished?
    return false if additional_time?(END_FIRST, 240)
    true
  end

  def finish_second_half?
    return false if second_half_finished?
    return false if additional_time?(END_SECOND, 360)
    true
  end

  def finish_third_part?
    return false if third_part_finished?
    return false if additional_time?(END_THIRD, 60)
    true
  end

  def finish_fourth_part?
    return false if fourth_part_finished?
    return false if additional_time?(END_FOURTH, 60)
    true
  end

  def first_half_finished?
    half_second
  end

  def second_half_finished?
    full_second
  end

  def third_part_finished?
    xtra_half_second
  end

  def fourth_part_finished?
    xtra_full_second
  end

  def finish_first_half!
    # puts "g2.4: #{Time.now-start}"
    self.home_goals = 0 unless home_goals
    self.guest_goals = 0 unless guest_goals
    self.home_half_goals = home_goals
    self.guest_half_goals = guest_goals
    self.half_second = second
    save
    # puts "g2.5: #{self.inspect}"
  end

  def finish_second_half!
    self.full_second = second-START_SECOND
    self.home_full_goals = home_goals if decision && !decision_done?
    self.guest_full_goals = guest_goals if decision && !decision_done?
    if !decision || decision_done?
      finish!
    else
      save
    end
  end

  def finish_third_part!
    self.xtra_half_second = second-START_THIRD
    self.home_xtra_half_goals = home_goals unless decision_done?
    self.guest_xtra_half_goals = guest_goals unless decision_done?
    save
  end

  def finish_fourth_part!
    self.xtra_full_second = second-START_FOURTH
    self.home_xtra_full_goals = home_goals unless decision_done?
    self.guest_xtra_full_goals = guest_goals unless decision_done?
    if decision_done?
      finish!
    else
      save
    end
  end

  def decision_done?
    home_goals != guest_goals
  end

  def update_second
    second += 60
  end

  def additional_time?(regular=2700, max=270)
    rand_base = max-(second-regular)
    return false if rand_base <= 0
    x = Random.new.rand(rand_base)
    y = rand_base/2
    x > y
  end

end
