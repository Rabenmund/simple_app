class LeaguesController < ApplicationController
  
  before_action :load_league, only: [:show, :run_matchday] 
  
  def index
    @leagues = League.all
  end
  
  def show
  end

  private
  
  def load_league
    @league = League.find(params[:id])
  end
  
end