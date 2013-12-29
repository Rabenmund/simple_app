class MatchdaysController < ApplicationController
  
  before_action :load_matchday
  
  def run
  end
  
  private
  
  def load_matchday
    season = League.find(params[:id])
    @matchday = season.matchdays.find(params[:matchday_id])
  end
end
