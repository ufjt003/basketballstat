require 'spec_helper'

describe HomeController, "GET index" do
  it "..." do
    get :index, format: :json
    response.status.should == 200
    response.body.should == 'realballerz api'
  end
end
