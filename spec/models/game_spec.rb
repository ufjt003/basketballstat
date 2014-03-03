require 'spec_helper'

describe Game do
  it { should validate_presence_of(:gametime) }
  it { should have_many(:teams) }
  it { should have_many(:players) }
end

describe Game, ".start .end" do
  let(:game) { FactoryGirl.create(:game) }
  let(:team) { FactoryGirl.create(:team) }
  let(:team2) { FactoryGirl.create(:team) }
  before { game.is_in_progress?.should be_false }

  describe ".start" do
    context "when game doesn't have 2 teams yet" do
      it { expect { game.start }.to raise_error(StandardError, 'game requires 2 teams to get started') }
    end

    context "when game has 2 teams" do
      before { game.add_team(team); game.add_team(team2) }
      it do
        game.start.should be_true
        game.is_in_progress?.should be_true
      end

      context 'when game is alreayd in progress' do
        before { game.start }
        it { expect { game.start }.to raise_error(StandardError, 'game is already in progress') }
      end
    end
  end

  describe ".finish" do
    context "when game is not in progress" do
      it { expect { game.finish }.to raise_error(StandardError, 'game is not in progress') }
    end

    context "when game is in progress" do
      before { game.add_team(team); game.add_team(team2); game.start }
      it do
        game.finish.should be_true
        game.is_in_progress?.should be_false
      end
    end
  end
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

  context "when game is in progress" do
    let(:team2) { FactoryGirl.create(:team) }
    let(:team3) { FactoryGirl.create(:team) }
    before { game.add_team(team); game.add_team(team2) }
    it 'should not add team to game' do
      expect { game.add_team(team3) }.to change(TeamStat, :count).by(0)
      game.teams.should_not include(team3)
    end
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

  context "when game is in progress" do
    let(:team2) { FactoryGirl.create(:team) }
    before { game.add_team(team2); game.start }

    it 'should not remove team from game' do
      game.remove_team(team) 
      game.teams.should include(team)
      game.players.should include(player)
    end
  end
end
