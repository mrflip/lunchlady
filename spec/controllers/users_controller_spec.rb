require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
end
