require 'spec_helper'

describe Team, "validations" do
  it { should validate_presence_of(:name) }
end

describe Team, "relations" do
  it { should have_many(:players) }
end

describe Team, "callbacks" do
  it "should create team stat afterwards" do
    team = FactoryGirl.create(:team)
    team.team_stat.should == TeamStat.last
    TeamStat.last.team.should == team
  end
end
