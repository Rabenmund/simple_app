require 'spec_helper'

describe LeaguesController, type: :controller do

  let(:league) { create :league }

  it "#show" do
    get :show, id: league.id
    expect(response).to render_template "leagues/show"
  end
end
