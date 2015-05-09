require 'spec_helper'

describe MatchdaysController, type: :controller do

  let(:matchday) { create :matchday }

  before { allow(Matchday).to receive(:find).and_return matchday }

  it "#show" do
    get :show, id: matchday.id
    expect(response).to render_template "matchdays/show"
  end

  context "#perform" do
    before { allow(matchday).to receive("perform!") }

    it "responds to html" do
      get :perform, id: matchday.id
      expect(response).to render_template :show
    end

    it "responds to js" do
      get :perform, format: :js, id: matchday.id
      expect(response).to render_template "matchdays/_perform"
    end
  end
end

