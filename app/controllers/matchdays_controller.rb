class MatchdaysController < ApplicationController
  protect_from_forgery except: :perform

  before_action :load_matchday

  def show
  end

  def perform
    @matchday.perform!
    UpdatePlayerStrength.after_matchday(@matchday)
    respond_to do |format|
      format.html { render :show }
      format.js { render partial: 'matchdays/perform' }
    end
  end

  private

  def load_matchday
    @matchday = Matchday.find(params[:id])
  end
end
