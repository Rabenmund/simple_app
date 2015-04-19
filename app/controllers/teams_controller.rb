class TeamsController < ApplicationController

  before_action :load_federation
  before_action :load_team, only: [:show, :edit, :update, :delete]

  def show
  end

  def new
    @team = @federation.teams.new
  end

  def create
    @team = @federation.teams.new(team_params)
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

  def load_federation
    @federation = Federation.find(params[:federation_id])
  end

  def load_team
    @team = @federation.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :short_name, :abbreviation)
  end

end

