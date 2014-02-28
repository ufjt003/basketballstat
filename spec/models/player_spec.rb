require 'spec_helper'

describe Player, "validations" do
  it { should validate_presence_of(:name) }
end

describe Player, "callbacks" do
  it "should create player stat afterwards" do
    player = FactoryGirl.create(:player)
    player.stat.should == PlayerStat.last
    PlayerStat.last.player.should == player
  end
end

describe Player, ".shoot" do
  let(:player) { FactoryGirl.create(:player) }
  it "should increment field_goal_attemped" do
    expect { player.shoot }.to change(player.stat, :field_goal_attempted).by(1)
  end
end
