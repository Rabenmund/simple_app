class SeasonsController < ApplicationController

  before_action :load_season, only: [:show]

  def index
    @seasons = Season.all
  end

  def show
  end

  private

  def load_season
    @season = Season.find(params[:id])
  end
end
