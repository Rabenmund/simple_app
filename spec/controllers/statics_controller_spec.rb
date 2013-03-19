require 'spec_helper'

describe StaticsController do
  
  it "should render the dashboard view" do
    get :dashboard
    controller.should render_template :dashboard
  end
  
end