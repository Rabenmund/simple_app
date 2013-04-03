# coding: utf-8

class Competition < ActiveRecord::Base
  attr_accessor :no_of_teams, :plan, :plan_position, :selected_matchday
  attr_accessible :name, :team_ids, :selected_matchday
  
  serialize :plan_positions
  
  validates :name, presence: true
  
  validate :not_more_than_no_of_teams
    
  has_and_belongs_to_many :teams
  has_many :matchdays, dependent: :destroy, order: "number ASC"
  has_many :games, through: :matchdays
  belongs_to :season
  
  scope :non_selected, where(season_id: nil)

  def finished?
#    matchdays.not_finished.empty?
# TODO Monster hack. mindestens abbrechen sobald der erste gefunden ist. geht das nicht besser?
    return false if matchdays.empty?
    @not_finished_mds = []
    matchdays.each { |m| @not_finished_mds << m unless m.games.not_finished.empty? && m.games.any? }
    @not_finished_mds.empty?
  end
    
  def no_of_teams
    @no_of_teams ||= 4
  end

  def no_of_matchdays
    (no_of_teams - 1) * 2
  end
  
  def plan
    @plan ||= first_half_plan.concat second_half_plan
  end
  
  # TODO aufraeumen model und ersetzen des attributes plan_position durch plan_positions (db persistent) - controller einbeziehen
  
  def plan_position
    @plan_position ||= reset_plan_position
  end
  
  def plan_positions
    plan_positions ||= plan_position # TODO removed by default when plan_position is generally removed
  end
  
  def update_plan_position(position=0, team_id=0) 
    plan_position[position] = team_id
  end
  
  def reset_plan_position
    teams.any? ? initialize_team_position : array_init_with_zero
  end
  
  def randomize_plan_position
    @plan_position = array_init_with_zero
    teams.each { |t| rand_position(t) }
  end
  
  def ready_to_persist?
    correct_number_of_teams? && !started?
  end
  
  def started?
    # definition der Startbedingungen erweitern, wenn dates eingefuehrt werden
    !matchdays.first.games.first.home_goals.nil? if matchdays.any?
  end
  
  private
  
  def correct_number_of_teams?
    teams.size == no_of_teams
  end
  
  def initialize_team_position
    # TODO change default position base to strength instead of order in teams collection

    @plan_position = array_init_with_zero
    
    pos = 0
    teams.each do |t|
      update_plan_position(pos, t.id)
      pos += 1
    end
    @plan_position
  end
  
  def array_init_with_zero
    Array.new(no_of_teams, 0) # => [ 0, 0, 0, 0, 0, 0 ]
  end
  
  def first_half_plan
    [
      [ [1,2], [3,4] ],
      [ [1,4], [2,3] ],
      [ [3,1], [4,2] ]
    ]
  end
  
  def second_half_plan
    first_half_plan.map! do |md| 
      md.map! do |g| 
        [g[1], g[0]]
      end
    end
  end

  def rand_position(team)
    rand_no = Random.rand(0...no_of_teams)
    plan_position[rand_no] == 0 ? update_plan_position(rand_no, team.id) : rand_position(team) # recursive
  end
  
  def not_more_than_no_of_teams
    errors.add(:teams, "Es sind zuviele Mannschaften ausgewählt. Erlaubt: ##{no_of_teams}. Ausgewählt: ##{teams.length}") if teams.length > no_of_teams
  end
end