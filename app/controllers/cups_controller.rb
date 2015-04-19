class CupsController < ApplicationController

  before_action :load_cup, only: [:show]

  def show
  end

  private

  def load_cup
    @cup = Cup.find(params[:id])
  end
end

