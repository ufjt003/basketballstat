require 'spec_helper'

describe Player, "validations" do
  it { should validate_presence_of(:name) }
end

describe Player, "relations" do
  it { should belong_to(:team) }
  it { should belong_to(:current_game) }
  it { should have_one(:all_time_stat) }
  it { should have_many(:game_stats) }
end

describe Player, "callbacks" do
  it "should create player all_time_stat afterwards" do
    player = FactoryGirl.create(:player)
    player.all_time_stat.should == AllTimePlayerStat.last
    AllTimePlayerStat.last.player.should == player
  end
end

describe Player do
  [:two_pointer_attempt, :two_pointer_make, :three_pointer_attempt, :three_pointer_make,
   :free_throw_attempt, :free_throw_make, :assist, :block, :steal,
   :rebound, :turnover, :foul].each do |play|
    describe "#{play}" do
      let(:team) { FactoryGirl.create(:complete_team) }
      let(:another_team) { FactoryGirl.create(:complete_team) }
      let(:game) { FactoryGirl.create(:game) }

      context "when a player is in a game" do
        before { game.add_home_team(team); game.add_away_team(another_team) }
        context "when the game is in progress" do
          before { game.start }
          it "player's + team's game stat and all_time_stat should be updated" do
            player = team.players.first
            player.send(play)
            player.all_time_stat.send(play).should == 1
            player.current_game_stat.send(play).should == 1
            team.all_time_stat.send(play).should == 1
            team.current_game_stat.send(play).should == 1
          end
        end

        context "when the game is not in progress" do
          it do
            player = team.players.first
            expect { player.send(play) }.to raise_error(Errors::InvalidMethodCallError)
          end
        end
      end

      context "when player is not in a game" do
        it do
          player = team.players.first
          expect { player.send(play) }.to raise_error(Errors::InvalidMethodCallError)
        end
      end
    end
  end
end

describe Player, ".leave_game" do
  let(:game) { FactoryGirl.create(:game) }
  let(:home_team) { FactoryGirl.create(:complete_team) }
  let(:away_team) { FactoryGirl.create(:complete_team) }
  let(:unregistered_player) { FactoryGirl.create(:player) }
  let(:last_home_player) { FactoryGirl.create(:player) }
  let(:last_away_player) { FactoryGirl.create(:player) }

  before do
    home_team.add_player(last_home_player)
    away_team.add_player(last_away_player)
    game.add_home_team(home_team)
    game.add_away_team(away_team)
  end

  context "when the player is not yet in the game" do
    it do
      p = home_team.players.first
      expect { p.leave_game(game) }.to raise_error(Errors::InvalidMethodCallError)
    end
  end

  it do
    p = home_team.players.first
    p.enter_game(game)
    p.leave_game(game)
    game.players_in_game.include?(p).should == false
  end
end

describe Player, ".enter_game" do
  let(:game) { FactoryGirl.create(:game) }
  let(:home_team) { FactoryGirl.create(:complete_team) }
  let(:away_team) { FactoryGirl.create(:complete_team) }
  let(:unregistered_player) { FactoryGirl.create(:player) }
  let(:last_home_player) { FactoryGirl.create(:player) }
  let(:last_away_player) { FactoryGirl.create(:player) }

  before do
    home_team.add_player(last_home_player)
    away_team.add_player(last_away_player)
    game.add_home_team(home_team)
    game.add_away_team(away_team)
  end

  it do
    p = home_team.players.first
    p.enter_game(game)
    p.reload.is_playing_in_game?(game).should == true
  end

  context "when the player is not registerd in the game" do
    it do
      expect { unregistered_player.enter_game(game) }.to raise_error(Errors::InvalidMethodCallError,
                                                                     "player #{unregistered_player.name} is not registered in the game")
    end
  end

  context "when the player is already playing in the game" do
    it do
      p = home_team.players.first
      p.enter_game(game)
      expect { p.enter_game(game) }.to raise_error(Errors::InvalidMethodCallError, "player #{p.name} is already playing in the game")
    end
  end

  context "if the game already has 5 players playing" do
    before do
      home_team.players[0..4].each { |p| p.enter_game(game) }
      away_team.players[0..4].each { |p| p.enter_game(game) }
    end

    it do
      expect { last_home_player.enter_game(game) }.to raise_error(Errors::InvalidMethodCallError, "home team already has 5 players playing")
    end

    it do
      expect { last_away_player.enter_game(game) }.to raise_error(Errors::InvalidMethodCallError, "away team already has 5 players playing")
    end

  end
end
