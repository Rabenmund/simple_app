class LeaguesController < ApplicationController

  before_action :load_season
  before_action :load_league, only: [:show]

  def show
  end

  private

  def load_season
    @season = Season.find(params[:season_id])
  end

  def load_league
    @league = League.find(params[:id])
  end
end
