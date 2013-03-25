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
    redirect_to @competiton if @competition.started?
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
    @competition.update_attribute(:plan_positions, @competition.plan_position)
    render :show
  end
  
  def randomize_plan_positions
    @competition.randomize_plan_position
    @competition.update_attribute(:plan_positions, @competition.plan_position)
    render :show
  end

  def persist_competition
    create_matchdays if @competition.ready_to_persist?
    render :show
  end
  
  def delete_matchdays_and_games
    delete_old_matchdays_and_games
    render :edit
  end
  
  private
  
  def delete_old_matchdays_and_games
    @competition.matchdays.destroy_all
  end
  
  def create_matchdays
    begin
      @competition.transaction do
        delete_old_matchdays_and_games
        number = 0
        @competition.plan.each do |matchday|
          number += 1
          created_matchday = create_matchday(number)
          matchday.each do |game|
            create_game(created_matchday, game)
          end
        end
      flash[:success] = "Wettbewerb #{@competition.name} erfolgreich gespeichert. #{@competition.matchdays.count} Spieltage und #{@competition.games.count} Spiele angelegt."
      end
    rescue
      flash[:error] = "Wettbewerb #{@competition.name} konnte nicht gespeichert werden"
    end
  end

  def create_matchday(number)
    @competition.matchdays.create!(number: number)
  end
  
  def create_game(matchday, game)
    matchday.games.create!(home_id: @competition.plan_positions[game[0]-1], guest_id: @competition.plan_positions[game[1]-1] )
  end

  def load_competition
    @competition = Competition.find(params[:id])
  end
  
  def set_controller_title
    @controller_title = "Wettbewerbe"
  end

end