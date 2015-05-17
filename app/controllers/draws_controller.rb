class DrawsController < ApplicationController

  before_action :load_matchday
  before_action :load_draw

  def show
    render 'matchdays/show'
  end

  def perform
    if @draw.can_be_performed?
      @draw.perform!
    end
    respond_to do |format|
      format.html { render 'matchdays/show' }
      format.js { render partial: 'matchdays/draws/perform' }
    end
  end

  private

  def load_matchday
    @matchday = Matchday.find(params[:matchday_id])
  end

  def load_draw
    @draw = @matchday.draw
  end
end

