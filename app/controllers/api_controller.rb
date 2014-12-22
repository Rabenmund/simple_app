class ApiController < ApplicationController
  def base_data
    base_data = {
      federation: {
        create: Federation.all.to_json,
        },
      team: {
        create: Team.all.to_json,
      },
    }
    render json: base_data
  end

  def season
    season = Season.find_by(year: params[:year])
    unless season
      render text: "No Season", status: 404
      return
    end

    #league_teams = {}
    #season.leagues.map{|l| league_teams.merge!({l.id.to_s => l.teams.pluck(:id)})}
    season_data = {
      season: {
        create: season
      },
      federation: {
        create: season.federations
      },
      league: {
        create: season.leagues,
      },
      cup: {
        create: season.cups,
      },
      matchday: {
        create: season.matchdays
      },
      game: {
        create: season.games
      },
      result: {
        create: season.results
      },
    }
    render json: season_data
  end
end
