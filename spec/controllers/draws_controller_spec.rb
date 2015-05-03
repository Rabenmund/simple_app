require 'spec_helper'

describe DrawsController, type: :controller do

  let(:draw) { create :draw }

  it "shows a draw" do
    get :show, id: draw.id, matchday_id: draw.matchday.id
    expect(response).to render_template :show
  end

  # it 'performs a draw' do
  #   get :perform, id: draw.id, matchday_id: draw.matchday.id
  #   expect(draw).to be_performed
  # end
end
