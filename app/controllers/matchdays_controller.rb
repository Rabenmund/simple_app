class MatchdaysController < ApplicationController

  before_action :load_matchday

  def run
  end

  def step
    unless @matchday.finished?
      @matchday.step
      respond_to do |format|
         format.html { render "run" }
         format.js { render partial: 'matchdays/step' }
       end
    else
      render "run"
    end
  end

  private

  def load_matchday
    @season = League.find(params[:league_id])
    @matchday = @season.matchdays.find(params[:id])
  end
end
