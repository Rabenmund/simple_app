# coding: utf-8

class Game < ActiveRecord::Base
  
  belongs_to :matchday
  has_one :league, through: :matchday
  
  belongs_to :home, class_name: "Team"
  belongs_to :guest, class_name: "Team"
  
  has_many :points
  
  validates_presence_of :home_id, :guest_id
  validates :matchday, presence: true
  
  scope :not_finished, -> { where(finished: false) }
  scope :finished, -> { where(finished: true) }

  def finish!
    update_attributes(finished: true)
  end
  
  def step
    return if finished
    update_attributes(home_goals: 0, guest_goals: 0) unless home_goals || guest_goals
    perform_event
    update_second
    save
    if to_be_finished?
      finish!
      CalculatePoints.calculate(self)
    end
  end
  
  private
  
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
    puts "second: ", second
    self.second += 60
  end
  
  def to_be_finished?
    second >= 5400
  end
    
end