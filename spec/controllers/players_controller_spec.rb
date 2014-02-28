require 'spec_helper'

describe PlayersController, "POST create" do
  it "should create a player" do
    expect {
      post :create, player: { name: "steve nash", number: 10 }
      response.status.should == 200
      response.body.should == { success: true, message: 'player created' }.to_json
    }.to change(Player, :count).by(1)
  end

  context "for wrong params" do
    it "should return error message" do
      post :create, player: { number: 10 }
      response.status.should == 400
    end
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

describe PlayersController do
  let(:player) { FactoryGirl.create(:player) }

  describe "POST shoot" do
    it "should set player stat accordingly" do
      post :shoot, id: player.id
      response.status.should == 200
      response.body.should == { success: true, message: "player's field goal attempted incremented" }.to_json
      player.stat.field_goal_attempted.should == 1
    end

    context "when player is not found" do
      it "should return 400" do
        post :shoot, id: player.id + 1
        response.status.should == 400
        response.body.should == { success: false, message: "player #{player.id + 1} not found" }.to_json
      end
    end
  end

  describe "POST makes_field_goal" do
    it "should set player stat accordingly" do
      post :make_field_goal, id: player.id
      response.status.should == 200
      response.body.should == { success: true, message: "player's field goal made incremented" }.to_json
      player.stat.field_goal_made.should == 1
    end
  end

  describe "POST shoots_three_pointer" do
    it "should set player stat accordingly" do
      post :shoot_three_pointer, id: player.id
      response.status.should == 200
      response.body.should == { success: true, message: "player's three pointer attempted incremented" }.to_json
      player.stat.three_pointer_attempted.should == 1
    end
  end

  describe "POST makes_three_pointer" do
    it "should set player stat accordingly" do
      post :make_three_pointer, id: player.id
      response.status.should == 200
      response.body.should == { success: true, message: "player's three pointer made incremented" }.to_json
      player.stat.three_pointer_made.should == 1
    end
  end

  describe "POST shoots_free_throw" do
    it "should set player stat accordingly" do
      post :shoot_free_throw, id: player.id
      response.status.should == 200
      response.body.should == { success: true, message: "player's free throw attempted incremented" }.to_json
      player.stat.free_throw_attempted.should == 1
    end
  end

  describe "POST makes_free_throw" do
    it "should set player stat accordingly" do
      post :make_free_throw, id: player.id
      response.status.should == 200
      response.body.should == { success: true, message: "player's free throw made incremented" }.to_json
      player.stat.free_throw_made.should == 1
    end
  end

  ['assist', 'block', 'steal', 'rebound', 'turnover'].each do |play|
    describe "POST #{play}" do
      it "should set player stat accordingly" do
        post play.to_sym, id: player.id
        response.status.should == 200
        response.body.should == { success: true, message: "player's #{play} incremented" }.to_json
        player.stat.send(play.to_sym).should == 1
      end
    end
  end
end



