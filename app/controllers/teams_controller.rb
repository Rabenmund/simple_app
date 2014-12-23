class TeamsController < ApplicationController

  before_action :load_team, only: [:show, :edit, :update, :delete]

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      render :show
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team.update_attributes(team_params)
      render :show
    else
      render :edit
    end
  end

  private

  def load_team
    @federation = Federation.find(params[:federation_id])
    @team = @federation.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :short_name, :abbreviation)
  end

end

