class LeaguesController < ApplicationController
  
  before_filter :load_league, only: [:show, :run_matchday] 
  
  def index
    @leagues = League.all
  end
  
  def show
  end
  
  def run_matchday
    @matchday = @league.matchdays.find(params[:matchday_id])
  end
  
  private
  
  def load_league
    @league = League.find(params[:id])
  end
  
end