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
  let(:team)   { FactoryGirl.create(:complete_team) }
  let(:another_team) { FactoryGirl.create(:complete_team) }
  let(:game)   { FactoryGirl.create(:game) }
  let(:solo_player) { FactoryGirl.create(:player) }
  let(:team_player) { team.players.first }

  describe "PUT undo" do
    context "game is in progress" do
      before { game.add_home_team(team); game.add_away_team(another_team) }
      before { game.start }

      before do
        put :rebound, id: team_player.id
        team_player.all_time_stat.send(:rebound).should == 1
        team_player.current_game_stat.send(:rebound).should == 1
        team.all_time_stat.send(:rebound).should == 1
        team.current_game_stat.send(:rebound).should == 1
      end

      it do
        put :undo, id: team_player.id
        team_player.all_time_stat.reload.send(:rebound).should == 0
        team_player.current_game_stat.reload.send(:rebound).should == 0
        team.all_time_stat.reload.send(:rebound).should == 0
        team.current_game_stat.reload.send(:rebound).should == 0
      end

      context "if the player is not in a game" do
        it do
          put :undo, id: solo_player.id
          response.status.should == 400
        end
      end
    end

    context "if the player is in a game but the game is not in progress" do
      it do
        put :undo, id: team_player.id
        response.status.should == 400
      end
    end
  end

  ['three_pointer_attempt', 'three_pointer_make', 'two_pointer_attempt', 'two_pointer_make',
   'free_throw_attempt', 'free_throw_make', 'assist', 'block', 'steal', 'rebound', 'turnover', 'foul'].each do |play|
    describe "PUT #{play}" do
      context "if the game is in progress" do
        before { game.add_home_team(team); game.add_away_team(another_team) }
        before { game.start }

        it "should set player all_time_stat accordingly" do
          put play.to_sym, id: team_player.id
          response.status.should == 200
          response.body.should == PlayerSerializer.new(team_player.reload).to_json
          team_player.all_time_stat.send(play.to_sym).should == 1
          team_player.current_game_stat.send(play.to_sym).should == 1
        end

        it "should set team's game and all_time stat, too" do
          put play.to_sym, id: team_player.id
          response.status.should == 200
          response.body.should == PlayerSerializer.new(team_player.reload).to_json
          team.all_time_stat.send(play.to_sym).should == 1
          team.current_game_stat.send(play.to_sym).should == 1
        end

        context "when player is not found" do
          it "should return 404" do
            put play.to_sym, id: team_player.id + 99999
            response.status.should == 404
          end
        end
      end

      context "if the player is not in a game" do
        it do
          put play.to_sym, id: solo_player.id
          response.status.should == 400
        end
      end

      context "if the player is in a game but the game is not in progress" do
        it do
          put play.to_sym, id: team_player.id
          response.status.should == 400
        end
      end
    end
  end
end
