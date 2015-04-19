require 'spec_helper'

describe SeasonsController, type: :controller do

  let(:season) { create :season }

  it "#index" do
    get :index
    expect(response).to render_template :index
  end

  it "#show" do
    get :show, id: season.id
    expect(response).to render_template :show
  end
end
