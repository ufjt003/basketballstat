require 'spec_helper'

describe Player, "validations" do
  it { should validate_presence_of(:name) }
end

describe Player, "callbacks" do
  it "should create player stat afterwards" do
    player = FactoryGirl.create(:player)
    PlayerStat.last.player.should == player
  end
end
