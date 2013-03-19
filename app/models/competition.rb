# coding: utf-8

class Competition < ActiveRecord::Base
  attr_accessor :no_of_teams, :plan, :plan_position, :selected_matchday
  attr_accessible :name, :team_ids, :selected_matchday
  
  validates :name, presence: true
  
  validate :not_more_than_no_of_teams
    
  has_and_belongs_to_many :teams
  has_many :matchdays, dependent: :destroy
  has_many :games, through: :matchdays
    
  def no_of_teams
    @no_of_teams ||= 4
  end
  
  def no_of_games_per_matchday
    no_of_teams div 2
  end
  
  def no_of_matchdays
    (no_of_teams - 1) * 2
  end
  
  def plan
    @plan ||= first_half_plan.concat second_half_plan
  end
  
  def plan_position
    @plan_position ||= reset_plan_position
  end
  
  def update_plan_position(position=0, team_id=0) 
    plan_position[position] = team_id
  end
  
  def reset_plan_position
    @plan_position = Array.new(no_of_teams, 0) # => [ 0, 0, 0, 0, 0, 0 ]
  end
  
  def randomize_plan_position
    teams.each do |t|
      rand_position(t)
    end
  end
  
  private
  
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
    rand_no = Random.rand(0...no_of_teams) - 1
    plan_position[rand_no] == 0 ? update_plan_position(rand_no, team.id) : rand_position(team) # hurra - eine rekursion
  end
  
  def not_more_than_no_of_teams
    errors.add(:teams, "Es sind zuviele Mannschaften ausgewählt. Erlaubt: ##{no_of_teams}. Ausgewählt: ##{teams.length}") if teams.length > no_of_teams
  end
end