require 'spec_helper'

describe Game do
  it { should validate_presence_of(:gametime) }
  it { should have_many(:teams) }
  it { should have_many(:players) }
end

describe Game, ".start .end .score" do
  let(:game) { FactoryGirl.create(:game) }
  let(:game_with_no_team) { FactoryGirl.create(:game) }
  let(:team) { FactoryGirl.create(:team) }
  let(:team2) { FactoryGirl.create(:team) }

  before "add players to teams" do
    5.times { team.add_player(FactoryGirl.create(:player)) }
    5.times { team2.add_player(FactoryGirl.create(:player)) }
  end

  before "set up game" do
    game.add_team(team)
    game.add_team(team2)
  end

  describe ".score" do
    it { game_with_no_team.score.should == [] }
    it { game.score.should == [ { "#{team.name}" => team.game_score },  { "#{team2.name}" => team2.game_score } ] }
  end

  describe ".start" do
    context "when game doesn't have 2 teams yet" do
      it { expect { game_with_no_team.start }.to raise_error(Errors::InvalidMethodCallError, 'game requires 2 teams to get started') }
    end

    context "when game has 2 teams" do
      it do
        game.start.should be_true
        game.is_in_progress?.should be_true
      end

      context 'when game is already in progress' do
        before { game.start }
        it { expect { game.start }.to raise_error(Errors::InvalidMethodCallError, 'game is already in progress') }
      end
    end
  end

  describe ".finish" do
    context "when game is not in progress" do
      it { expect { game.finish }.to raise_error(Errors::InvalidMethodCallError, 'game is not in progress') }
    end

    context "when game is in progress" do
      it do
        game.start
        game.finish.should be_true
        game.is_in_progress?.should be_false
      end
    end
  end
end

describe Game, ".add_team" do
  let(:game) { FactoryGirl.create(:game) }
  let(:team) { FactoryGirl.create(:team) }
  before 'add 5 players to team' do
    5.times { team.add_player(FactoryGirl.create(:player)) }
  end

  it "should create team_stat for this game" do
    expect { game.add_team(team) }.to change(TeamStat, :count).by(1)
    game.teams.should include(team)
    TeamStat.last.game.should == game
  end

  it "should create player_stat's for this game" do
    expect { game.add_team(team) }.to change(PlayerStat, :count).by(5)
    game.players.size.should == 5
  end

  context "when team has less than 5 teams" do
    let(:team_with_four_players) { FactoryGirl.create(:team) }
    before { 4.times { team_with_four_players.add_player(FactoryGirl.create(:player)) } }
    it { expect { game.add_team(team_with_four_players) }.to raise_error(Errors::InvalidMethodCallError, 'team has less than 5 players') }
  end

  context "when game already has 2 teams" do
    let(:team2) { FactoryGirl.create(:team) }
    let(:team3) { FactoryGirl.create(:team) }
    before 'add 5 players to team' do
      5.times { team2.add_player(FactoryGirl.create(:player)) }
      5.times { team3.add_player(FactoryGirl.create(:player)) }
    end

    before 'add 2 teams to game' do
      game.add_team(team2)
      game.add_team(team3)
    end

    it { expect { game.add_team(team) }.to raise_error(Errors::InvalidMethodCallError, 'game already has 2 teams') }

    context 'when game is alreayd in progress' do
      before { game.start }
      it { expect { game.add_team(team) }.to raise_error(Errors::InvalidMethodCallError, 'game is already in progress') }
    end
  end
end

describe Game, ".remove_team" do
  let(:game) { FactoryGirl.create(:game) }
  let(:team) { FactoryGirl.create(:team) }

  before { 5.times { team.add_player(FactoryGirl.create(:player)) } }
  before { game.add_team(team) }

  it "should remove team and its players from game" do
    game.remove_team(team)
    game.teams.should_not include(team)
    game.players.count.should == 0
  end

  it "should remove team_stat as well" do
    game.remove_team(team)
    TeamStat.where(game_id: game.id, team_id: team.id).should be_empty
  end

  it "should remove player_stat" do
    game.remove_team(team)
    PlayerStat.where(game_id: game.id, player_id: team.players).should be_empty
  end

  context "when game is in progress" do
    let(:team2) { FactoryGirl.create(:team) }
    before "add another team and start game" do
      5.times { team2.add_player(FactoryGirl.create(:player)) }
      game.add_team(team2)
      game.start
    end

    it 'should not remove team from game' do
      expect { game.remove_team(team) }.to raise_error(Errors::InvalidMethodCallError, 'game is already in progress')
    end
  end
end
