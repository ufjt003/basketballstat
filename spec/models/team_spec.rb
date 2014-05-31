require 'spec_helper'

describe Team, "validations" do
  it { should validate_presence_of(:name) }
end

describe Team, "relations" do
  it { should have_many(:players) }
  it { should belong_to(:current_game) }
  it { should have_one(:all_time_stat) }
  it { should have_many(:game_stats) }
end

describe Team, "callbacks" do
  it "should create team all_time_stat afterwards" do
    team = FactoryGirl.create(:team)
    team.all_time_stat.should == AllTimeTeamStat.last
    AllTimeTeamStat.last.team.should == team
  end
end

describe Team, "#add_player, #remove_player" do
  let(:team) { FactoryGirl.create(:team) }
  let(:player) { FactoryGirl.create(:player) }
  let(:complete_team) { FactoryGirl.create(:complete_team) }
  let(:complete_team2) { FactoryGirl.create(:complete_team) }
  let(:game) { FactoryGirl.create(:game) }

  context "when a player is already in the team" do
    before { team.add_player(player) }
    it { expect { team.add_player(player) }.to raise_error(Errors::InvalidMethodCallError, "player #{player.name} already in the team") }
  end

  context "when a player is not in the team" do
    it { expect { team.remove_player(player) }.to raise_error(Errors::InvalidMethodCallError, "player #{player.name} not in the team") }
  end

  context "when a team is currently playing in a game" do
    before do
      game.add_home_team(complete_team)
      game.add_away_team(complete_team2)
      game.start
    end

    it do
      expect { complete_team.add_player(player) }.to raise_error(Errors::InvalidMethodCallError, 
                                                                 "team #{complete_team.name} currently playing in a game")
    end

    it do
      expect { complete_team.remove_player(player) }.to raise_error(Errors::InvalidMethodCallError, 
                                                                 "team #{complete_team.name} currently playing in a game")
    end

  end
end
