require 'spec_helper'

describe Player, "validations" do
  it { should validate_presence_of(:name) }
end

describe Player, "relations" do
  it { should belong_to(:team) }
  it { should belong_to(:game) }
end

describe Player, "callbacks" do
  it "should create player all_time_stat afterwards" do
    player = FactoryGirl.create(:player)
    player.all_time_stat.should == AllTimePlayerStat.last
    AllTimePlayerStat.last.player.should == player
  end
end

describe Player, ".shoot" do
  let(:player) { FactoryGirl.create(:player) }
  let(:team) { FactoryGirl.create(:team) }
  let(:game) { FactoryGirl.create(:game) }

  it "should increment field_goal_attemped" do
    expect { player.shoot }.to change(player.all_time_stat, :field_goal_attempted).by(1)
  end

  context "when a player is in a game" do
    before { team.add_player(player) }
    before { game.add_team(team) }
    it do
      player.shoot
      player.all_time_stat.field_goal_attempted.should == 1
      player.game_stat.field_goal_attempted.should == 1
      team.all_time_stat.field_goal_attempted.should == 1
      team.game_stat.field_goal_attempted.should == 1
    end
  end
end
