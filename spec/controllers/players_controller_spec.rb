require 'spec_helper'

describe PlayersController, "POST create" do
  it "should create a player" do
    expect {
      post :create, player: { name: "steve nash", number: 10 }
      response.status.should == 200
      response.body.should == PlayerSerializer.new(Player.last).to_json
    }.to change(Player, :count).by(1)
  end

  context "for wrong params" do
    it "should return error message" do
      post :create, player: { number: 10 }
      response.status.should == 422
    end
  end
end

describe PlayersController, "GET show" do
  it "should return player info" do
    player = FactoryGirl.create(:player)
    get :show, id: player.id
    response.status.should == 200
    response.body.should == PlayerSerializer.new(player).to_json
  end
end

describe PlayersController do
  let(:player) { FactoryGirl.create(:player) }
  let(:team)   { FactoryGirl.create(:team) }
  let(:game)   { FactoryGirl.create(:game) }

  ['three_pointer_attempt', 'three_pointer_make', 'two_pointer_attempt', 'two_pointer_make',
   'free_throw_attempt', 'free_throw_make', 'assist', 'block', 'steal', 'rebound', 'turnover', 'foul'].each do |play|
    describe "PUT #{play}" do
      it "should set player all_time_stat accordingly" do
        put play.to_sym, id: player.id
        response.status.should == 200
        response.body.should == PlayerSerializer.new(player.reload).to_json
        player.all_time_stat.send(play.to_sym).should == 1
      end

      context "when player belongs to a team" do
        before { team.players << player }
        it "should set team all_time_stat, too" do
          post play.to_sym, id: player.id
          response.status.should == 200
          response.body.should == PlayerSerializer.new(player.reload).to_json
          team.all_time_stat.send(play.to_sym).should == 1
        end
      end

      context "when player belongs to a game" do
        before { team.add_player(player) }
        before { 4.times { team.add_player(FactoryGirl.create(:player)) } }
        before { game.add_home_team(team) }
        it "should set game stat" do
          post play.to_sym, id: player.id
          response.status.should == 200
          response.body.should == PlayerSerializer.new(player.reload).to_json
          player.current_game_stat.send(play.to_sym).should == 1
        end
      end

      context "when player is not found" do
        it "should return 404" do
          post play.to_sym, id: player.id + 1
          response.status.should == 404
        end
      end

    end
  end
end
