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
      it { should assign_to(:competition).with competition.last }
      it { should redirect_to competition.last }
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
  end

end