require 'spec_helper'

describe Team, "validations" do
  it { should validate_presence_of(:name) }
end

describe Team, "relations" do
  it { should have_many(:players) }
  it { should belong_to(:game) }
end

describe Team, "callbacks" do
  it "should create team all_time_stat afterwards" do
    team = FactoryGirl.create(:team)
    team.all_time_stat.should == AllTimeTeamStat.last
    AllTimeTeamStat.last.team.should == team
  end
end

describe Team, ".shoot" do
  let(:team) { FactoryGirl.create(:team) }
  it "should increment field_goal_attemped" do
    expect { team.shoot }.to change(team.all_time_stat, :field_goal_attempted).by(1)
  end
end
