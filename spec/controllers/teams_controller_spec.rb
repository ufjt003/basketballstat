require 'spec_helper'

describe TeamsController, "POST create" do
  it "should create a team" do
    expect {
      post :create, team: { name: "phoenix suns" }
      response.status.should == 200
      response.body.should == TeamSerializer.new(Team.last).to_json
    }.to change(Team, :count).by(1)
  end

  context "for wrong params" do
    it "should return error message" do
      post :create, team: { wrong_param: 10 }
      response.status.should == 422
      JSON.parse(response.body)["errors"].should_not be_nil
    end
  end
end

describe TeamsController, "GET show" do
  it "should return team info" do
    team = FactoryGirl.create(:team)
    get :show, id: team.id
    response.status.should == 200
    response.body.should == TeamSerializer.new(team).to_json
  end
end

describe TeamsController, "POST add_player" do
  let(:team) { FactoryGirl.create(:team) }
  let(:player) { FactoryGirl.create(:player) }

  it "should add a player to a team" do
    post :add_player, id: team.id, player_id: player.id
    response.status.should == 200
    response.body.should == { success: true, message: 'add_player successful' }.to_json
    team.players.should include(player)
    player.reload.team.should == team
  end

  context "when a player is not found" do
    it "should not add a player to a team" do
      post :add_player, id: team.id, player_id: player.id + 1
      response.status.should == 404
      JSON.parse(response.body)["success"].should be_false
      team.players.should be_empty
    end
  end
end

describe TeamsController, "POST remove_player" do
  let(:team) { FactoryGirl.create(:team) }
  let(:player) { FactoryGirl.create(:player) }

  before { team.players << player }

  it "should remove a player from a team" do
    post :remove_player, id: team.id, player_id: player.id
    response.status.should == 200
    response.body.should == { success: true, message: 'remove_player successful' }.to_json
    team.players.should_not include(player)
    player.reload.should_not be_nil
  end
end

