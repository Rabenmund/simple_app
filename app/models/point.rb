class Point < ActiveRecord::Base
  attr_accessible :points, :team_id, :game_id, :league_id, :goals, :against, :win, :draw, :lost
  
  belongs_to :game
  belongs_to :team
  belongs_to :league
  
end
