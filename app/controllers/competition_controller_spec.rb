# coding: utf-8

class CompetitionsController < ApplicationController
    
  before_filter :load_competition, only: [:show, :edit, :update]
  before_filter :set_controller_title
    
	def index
    @title = "Wettbewerbe - Übersicht"
    @competitions = Competition.order("name ASC")
	end
  
  def show
    @title = "#{@competition.name} - Details"
  end
  
  def new
    @title = "Neuen Wettbewerb anlegen"
    @competition = Competition.new
  end
  
  def create 
    @competition = Competition.new(params[:competition])
    if @competition.save
      flash[:success] = "Wettbewerb #{@competition.name} erfolgreich angelegt"
      redirect_to @competition
    else
      render :new
    end
  end
  
  def edit
    @title = "#{@competition.name} bearbeiten"
  end
  
  def update
    if @competition.update_attributes(params[:competition])
      flash[:success] = "Wettbewerb #{@competition.name} erfolgreich bearbeitet"
      redirect_to @competition
    else
      render :edit
    end
  end
  
  private

  def load_competition
    @competition = Competition.find(params[:id])
  end
  
  def set_controller_title
    @controller_title = "Wettbewerbe"
  end

end