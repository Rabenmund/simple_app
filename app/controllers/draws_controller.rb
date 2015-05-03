class DrawsController < ApplicationController

  before_action :load_matchday
  before_action :load_draw

  def show
  end

  def perform
    if @draw.can_be_performed?
      @draw.perform!
    end
    render :show
  end

  private

  def load_matchday
    @matchday = Matchday.find(params[:matchday_id])
  end

  def load_draw
    @draw = @matchday.draw
  end
end

