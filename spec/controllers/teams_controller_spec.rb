require 'spec_helper'

describe TeamsController, "POST create" do
  it "should create a team" do
    expect {
      post :create, team: { name: "phoenix suns" }
      response.status.should == 200
      response.body.should == { success: true, message: 'team created' }.to_json
    }.to change(Team, :count).by(1)
  end

  context "for wrong params" do
    it "should return error message" do
      post :create, team: { wrong_param: 10 }
      response.status.should == 400
    end
  end
end

describe TeamsController, "GET show" do
  it "should return team info" do
    team = FactoryGirl.create(:team)
    get :show, id: team.id
    response.status.should == 200
    response.body.should == team.to_json
  end
end

