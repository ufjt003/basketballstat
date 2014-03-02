require 'spec_helper'

describe Game do
  it { should validate_presence_of(:gametime) }
  it { should have_many(:teams) }
end

describe Game, ".add_team" do
  let(:game) { FactoryGirl.create(:game) }

  it "should create team_stat for this game" do
    team = FactoryGirl.create(:team)
    expect { game.add_team(team) }.to change(TeamStat, :count).by(1)
    game.teams.should include(team)
    TeamStat.last.game.should == game
  end
end

describe Game, ".remove_team" do
  let(:game) { FactoryGirl.create(:game) }
  let(:team) { FactoryGirl.create(:team) }
  before { game.add_team(team) }
  before { game.teams.should include(team) }
  before { TeamStat.where(game_id: game.id, team_id: team.id).size.should == 1 }

  it "should remove team from game" do
    game.remove_team(team)
    game.teams.should_not include(team)
  end

  it "should remove team_stat as well" do
    game.remove_team(team)
    TeamStat.where(game_id: game.id, team_id: team.id).should be_empty
  end
end

