require 'spec_helper'

describe Player, "validations" do
  it { should validate_presence_of(:name) }
end

describe Player, "relations" do
  it { should belong_to(:team) }
  it { should belong_to(:current_game) }
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
      let(:player) { FactoryGirl.create(:player) }
      let(:team) { FactoryGirl.create(:team) }
      let(:game) { FactoryGirl.create(:game) }
      before { 5.times { team.add_player(FactoryGirl.create(:player)) } }

      it "should increment #{play}" do
        expect { player.send(play) }.to change(player.all_time_stat, play).by(1)
      end

      context "when a player is in a game" do
        before { team.add_player(player) }
        before { game.add_team(team) }
        it "player's + team's game stat and all_time_stat should be updated" do
          player.send(play)
          player.all_time_stat.send(play).should == 1
          player.current_game_stat.send(play).should == 1
          team.all_time_stat.send(play).should == 1
          team.current_game_stat.send(play).should == 1
        end
      end
    end
  end
end

