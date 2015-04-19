require 'spec_helper'

describe CupsController, type: :controller do

  let(:cup) { create :cup }

  it "#show" do
    get :show, id: cup.id
    expect(response).to render_template "cups/show"
  end
end

