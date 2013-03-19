# coding: utf-8

class CompetitionsController < ApplicationController
    
  before_filter :load_competition, except: [:index, :new, :create]
  before_filter :set_controller_title
    
	def index
    @title = "Wettbewerbe - Übersicht"
    @competitions = Competition.order("name ASC")
	end
  
  def show
    @title = "#{@competition.name} - Details"
    puts "in :show"
  end
  
  def new
    @title = "Neuen Wettbewerb anlegen"
    @competition = Competition.new
    @teams = Team.all
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
    puts "in :update"
    if @competition.update_attributes(params[:competition])
      flash[:success] = "Wettbewerb #{@competition.name} erfolgreich bearbeitet"
      redirect_to @competition
    else
      render :edit
    end
  end
  
  def select_plan_position
    @competition.update_plan_position(params[:position], params[:selected_team].id )
    render :show
  end
  
  def reset_plan_positions
    @competition.reset_plan_position
    render :show
  end
  
  def randomize_plan_positions
    @competition.randomize_plan_position
    render :show
  end
  
  def select_planned_matchday
    @planned_md = params[:planned_md]
    render :show
  end
  
  private

  def load_competition
    @competition = Competition.find(params[:id])
  end
  
  def set_controller_title
    @controller_title = "Wettbewerbe"
  end

end