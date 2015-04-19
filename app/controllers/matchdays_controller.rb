class MatchdaysController < ApplicationController

  before_action :load_matchday, only: [:show]

  def show
  end

  private

  def load_matchday
    @matchday = Matchday.find(params[:id])
  end
end
