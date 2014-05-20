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

describe Team, "#add_team, #remove_team" do
  let(:team) { FactoryGirl.create(:team) }
  let(:player) { FactoryGirl.create(:player) }

  context "when a player is already in the team" do
    before { team.add_player(player) }
    it { expect { team.add_player(player) }.to raise_error(StandardError, "player #{player.name} already in the team") }
  end

  context "when a player is not in the team" do
    it { expect { team.remove_player(player) }.to raise_error(StandardError, "player #{player.name} not in the team") }
  end
end
