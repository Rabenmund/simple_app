class Point < ActiveRecord::Base
  attr_accessible :points, :team_id, :game_id
  
  belongs_to :game
  belongs_to :team
  
end
