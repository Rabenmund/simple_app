class Competition < ActiveRecord::Base
  attr_accessor :no_of_teams, :plan
  attr_accessible :name
  
  validates :name, presence: true
    
  has_and_belongs_to_many :teams 
    
  def no_of_teams
    @no_of_teams ||= 6
  end
  
  def plan
    @plan ||= [
      [ [1,2], [3,4] ],
      [ [1,4], [2,3] ],
      [ [3,1], [4,2] ]
    ]
  end
  
end