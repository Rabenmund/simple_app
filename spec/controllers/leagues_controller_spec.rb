require 'spec_helper'

describe LeaguesController, type: :controller do

  let(:season) { create :season }
  let(:league) { create :league, season: season }

  it "#show" do
    get :show, season_id: season.id, id: league.id
    expect(response).to render_template "leagues/show"
  end
end
