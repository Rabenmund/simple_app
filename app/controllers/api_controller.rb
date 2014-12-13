class ApiController < ApplicationController
  def base_data
    render json: {federation: Federation.all.to_json, teams: Team.all.to_json }
  end
end
