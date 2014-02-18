require 'spec_helper'

describe PlayersController, "POST create" do
  it "should create a player" do
    expect {
      post :create, player: { name: "steve nash", number: 10 }
      response.status.should == 200
      response.body.should == { success: true, message: 'player created' }.to_json
    }.to change(Player, :count).by(1)
  end
end

describe PlayersController, "GET show" do
  it "should return player info" do
    player = FactoryGirl.create(:player)
    get :show, id: player.id
    response.status.should == 200
    response.body.should == player.to_json
  end
end

describe PlayersController, "POST shoots" do
  let(:player) { FactoryGirl.create(:player) }

  it "should set player stat accordingly" do
    post :shoots, id: player.id
    response.status.should == 200
    response.body.should == { success: true, message: "player's field goal attempted incremented" }.to_json
    player.player_stat.field_goal_attempted.should == 1
  end
end

describe PlayersController, "POST makes_field_goal" do
  let(:player) { FactoryGirl.create(:player) }

  it "should set player stat accordingly" do
    post :makes_field_goal, id: player.id
    response.status.should == 200
    response.body.should == { success: true, message: "player's field goal made incremented" }.to_json
    player.player_stat.field_goal_made.should == 1
  end
end
