require 'spec_helper'

describe Game do
  it { should validate_presence_of(:gametime) }
  it { should have_many(:teams) }
  it { should have_many(:players) }
end

describe Game, ".add_team" do
  let(:game) { FactoryGirl.create(:game) }
  let(:team) { FactoryGirl.create(:team) }
  let(:player) { FactoryGirl.create(:player) }
  let(:player2) { FactoryGirl.create(:player) }
  before { team.add_player(player); team.add_player(player2) }

  it "should create team_stat for this game" do
    expect { game.add_team(team) }.to change(TeamStat, :count).by(1)
    game.teams.should include(team)
    TeamStat.last.game.should == game
  end

  it "should create player_stat's for this game" do
    expect { game.add_team(team) }.to change(PlayerStat, :count).by([player, player2].size)
    game.players.should include(player)
    game.players.should include(player2)
  end
end

describe Game, ".remove_team" do
  let(:game) { FactoryGirl.create(:game) }
  let(:team) { FactoryGirl.create(:team) }
  let(:player) { FactoryGirl.create(:player) }

  before { team.add_player(player) }
  before { game.add_team(team) }
  before { game.teams.should include(team) }
  before { game.players.should include(player) }
  before { TeamStat.where(game_id: game.id, team_id: team.id).size.should == 1 }
  before { PlayerStat.where(game_id: game.id, player_id: player.id).size.should == 1 }

  it "should remove team and its players from game" do
    game.remove_team(team)
    game.teams.should_not include(team)
    game.players.should_not include(player)
  end

  it "should remove team_stat as well" do
    game.remove_team(team)
    TeamStat.where(game_id: game.id, team_id: team.id).should be_empty
  end

  it "should remove player_stat" do
    game.remove_team(team)
    PlayerStat.where(game_id: game.id, player_id: player.id).should be_empty
  end
end

