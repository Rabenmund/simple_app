# coding: utf-8

class SeasonsController < ApplicationController
    
  before_filter :load_season, only: [:show, :edit, :update]
  before_filter :set_controller_title
    
	def index
    @title = "Saisons - Übersicht"
    @seasons = Season.order("name ASC")
	end
  
  def show
    @title = "#{@season.name} - Details"
  end
  
  def new
    @title = "Neue Saison anlegen"
    @season = Season.new
    @competitions = Competition.non_selected.concat(@season.competitions)
  end
  
  def create 
    @season = Season.new(params[:season])
    if @season.save
      flash[:success] = "Saison #{@season.name} erfolgreich angelegt"
      redirect_to @season
    else
      render :new
    end
  end
  
  def edit
    @title = "#{@season.name} bearbeiten"
    @competitions = Competition.non_selected.concat(@season.competitions)
  end
  
  def update
    if @season.update_attributes(params[:season])
      flash[:success] = "Saison #{@season.name} erfolgreich bearbeitet"
      redirect_to @season
    else
      render :edit
    end
  end
  
  private

  def load_season
    @season = Season.find(params[:id])
  end
  
  def set_controller_title
    @controller_title = "Saisons"
  end
  
end