require 'spec_helper'

describe MatchdaysController, type: :controller do

  let(:matchday) { create :matchday }

  it "#show" do
    get :show, id: matchday.id
    expect(response).to render_template "matchdays/show"
  end
end

