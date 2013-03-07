# coding: utf-8

class TeamsController < ApplicationController
    
  before_filter :load_team, only: [:show, :edit, :update]
  before_filter :set_controller_title
    
	def index
    @title = "Mannschaften - Übersicht"
    @teams = Team.order("created_at ASC")
	end
  
  def show
    @title = "#{@team.name} - Details"
  end
  
  def new
    @title = "Neue Mannschaft anlegen"
    @team = Team.new
  end
  
  def create 
    @team = Team.new(params[:team])
    if @team.save
      flash[:success] = "Mannschaft #{@team.name} erfolgreich angelegt"
      redirect_to @team
    else
      render :new
    end
  end
  
  def edit
    @title = "#{@team.name} bearbeiten"
  end
  
  def update
    if @team.update_attributes(params[:team])
      flash[:success] = "Mannschaft #{@team.name} erfolgreich bearbeitet"
      redirect_to @team
    else
      render :edit
    end
  end
  
  private

  def load_team
    @team = Team.find(params[:id])
  end
  
  def set_controller_title
    @controller_title = "Mannschaften"
  end

end
