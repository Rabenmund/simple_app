require 'spec_helper'

describe TeamsController do
  
  let(:team) { create :team }
  
  describe "#index" do
    before { team; get :index }
    it { should respond_with :success }
    it { should assign_to(:teams).with [team] }
    it { should render_template :index }
  end
  
  describe "#show" do
    before { get :show, id: team.id }
    it { should respond_with :success }
    it { should assign_to(:team).with team }
    it { should render_template :show }
  end
  
  describe "#new" do
    before { get :new }
    it { should respond_with :success }
    it { should assign_to(:team) }
    it { should render_template :new }
  end
  
  describe "#create" do
    context "with valid attributes" do
      before { post :create, team: attributes_for(:team)  }
      it { should assign_to(:team).with Team.last }
      it { should redirect_to Team.last }
    end
    context "with invalid attributes" do
      before { post :create, team: {} }
      it { should render_template :new }
    end
  end
  
  describe "#edit" do
    before { get :edit, id: team.id }
    it { should respond_with :success }
    it { should assign_to(:team).with team }
    it { should render_template :edit }
  end
  
  describe "#update" do
    context "with valid attributes" do
      before { put :update, id: team.id, team: attributes_for(:team) }
      it { should assign_to(:team).with team }
      it { should redirect_to team }
    end
    context "with invalid attributes" do
      before { put :update, id: team.id, team: {name: ""} }
      it { should render_template :edit }
    end
  end
  
end