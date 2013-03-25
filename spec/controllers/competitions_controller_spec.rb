require 'spec_helper'

describe CompetitionsController do
  
  let(:competition) { create :competition }
  
  describe "#index" do
    before { competition; get :index }
    it { should respond_with :success }
    it { should assign_to(:competitions).with [competition] }
    it { should render_template :index }
  end
  
  describe "#show" do
    before { get :show, id: competition.id }
    it { should respond_with :success }
    it { should assign_to(:competition).with competition }
    it { should render_template :show }
  end
  
  describe "#new" do
    before { get :new }
    it { should respond_with :success }
    it { should assign_to(:competition) }
    it { should render_template :new }
  end
  
  describe "#create" do
    context "with valid attributes" do
      before { post :create, competition: attributes_for(:competition)  }
      it { should assign_to(:competition).with Competition.last }
      it { should redirect_to Competition.last }
    end
    context "with invalid attributes" do
      before { post :create, competition: {} }
      it { should render_template :new }
    end
  end
  
  describe "#edit" do
    before { get :edit, id: competition.id }
    it { should respond_with :success }
    it { should assign_to(:competition).with competition }
    it { should render_template :edit }
  end
  
  describe "#update" do
    context "with valid attributes" do
      before { put :update, id: competition.id, competition: attributes_for(:competition) }
      it { should assign_to(:competition).with competition }
      it { should redirect_to competition }
    end
    context "with invalid attributes" do
      before { put :update, id: competition.id, competition: {name: ""} }
      it { should render_template :edit }
    end
    
    it "redirects if competition is started" do
      competition.stub(started?: true)
      put :update, id: competition.id, competition: attributes_for(:competition)
      response.should redirect_to @competition
    end
    
  end
  
  describe "#persist_competition" do
    it "does not persist a competition that is not ready_to_persist" do
      get :persist_competition, id: competition.id
      Competition.find(competition.id).matchdays.count.should eq 0
      Competition.find(competition.id).games.count.should eq 0
    end
    
    it "persists a competition by creating matchdays and games" do
      competition_ready = create :competition_ready
      get :persist_competition, id: competition_ready.id
      Competition.find(competition_ready.id).matchdays.count.should eq competition_ready.no_of_matchdays
      Competition.find(competition_ready.id).games.count.should eq (competition_ready.no_of_matchdays * competition_ready.no_of_teams / 2 )
    end
      
    it "removes old matchdays and games when persisting a competition" do
      game = create :game
      (game.competition.no_of_teams-2).times { game.competition.teams << create(:team) }
      get :persist_competition, id: game.competition.id
      Competition.find(game.competition.id).matchdays.count.should eq game.competition.no_of_matchdays
      Competition.find(game.competition.id).games.count.should eq (game.competition.no_of_matchdays * game.competition.no_of_teams / 2 )
    end
      
  end

end