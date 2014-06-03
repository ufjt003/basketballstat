require 'spec_helper'

describe GamesController, "DELETE destroy" do
  let(:team_with_5_players) { FactoryGirl.create(:complete_team) }
  let(:another_team_with_5_players) { FactoryGirl.create(:complete_team) }
  let(:team_with_no_player) { FactoryGirl.create(:team) }

  before 'create a game' do
    post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") },
                  home_team_id: team_with_5_players.id, away_team_id: another_team_with_5_players.id
  end

  it "should delete a game" do
    expect {
      delete :destroy, id: Game.last.id
      response.status.should == 200
    }.to change(Game, :count).by(-1)
  end
end

describe GamesController, "POST create" do
  let(:team_with_5_players) { FactoryGirl.create(:complete_team) }
  let(:another_team_with_5_players) { FactoryGirl.create(:complete_team) }
  let(:team_with_no_player) { FactoryGirl.create(:team) }

  it "should create a game" do
    expect {
      post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") }
      response.status.should == 200
      response.body.should == GameSerializer.new(Game.last).to_json
    }.to change(Game, :count).by(1)
  end

  context "even when game time is not given" do
    it { expect {
      post :create, game: { wrong_params: "something" }
      response.status.should == 200
      response.body.should == GameSerializer.new(Game.last).to_json
    }.to change(Game, :count).by(1) }
  end

  context "even when game params is empty" do
    it { expect {
      post :create, game: {}
      response.status.should == 400
    }.to change(Game, :count).by(0) }
  end

  context "when a existing team_id is given" do
    it { expect {
      post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") },
                    home_team_id: team_with_5_players.id, away_team_id: another_team_with_5_players.id
      response.status.should == 200
      response.body.should == GameSerializer.new(Game.last).to_json
      Game.last.teams.size.should == 2
    }.to change(Game, :count).by(1) }
  end

  context "when home and away team are the same" do
    it { expect {
      post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") },
                    home_team_id: team_with_5_players.id, away_team_id: team_with_5_players.id
      response.status.should == 400
    }.to change(Game, :count).by(0) }
  end

  context "when a non-existing team_id is given" do
    it { expect {
      post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") }, home_team_id: team_with_5_players.id + 99
      response.status.should == 404
    }.to change(Game, :count).by(0) }
  end

  context "when a team with no player is given" do
    it { expect {
      post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") }, home_team_id: team_with_no_player.id
      response.status.should == 400
    }.to change(Game, :count).by(0) }
  end
end

describe GamesController, "GET show" do
  let(:game) { FactoryGirl.create(:game) }
  it "should return game info" do
    get :show, id: game.id
    response.status.should == 200
    response.body.should == GameSerializer.new(game).to_json
  end
end

describe GamesController, "GET home_team_stat, away_team_stat, home_player_stats, away_player_stats, home_team_players, away_team_players" do
  let(:home_team) { FactoryGirl.create(:complete_team) }
  let(:away_team) { FactoryGirl.create(:complete_team) }
  let(:game) { FactoryGirl.create(:game) }

  before do
    game.add_home_team(home_team)
    game.add_away_team(away_team)
  end

  context "when game id is exsiting" do
    it do
      get :home_team_stat, id: game.id
      response.body.should == TeamStatSerializer.new(home_team.game_stat(game)).to_json
    end

    it do
      get :away_team_stat, id: game.id
      response.body.should == TeamStatSerializer.new(away_team.game_stat(game)).to_json
    end

    it do
      get :home_player_stats, id: game.id
      stats = game.home_team.players.map { |p| p.game_stat(game) }
      response.body.should == ActiveModel::ArraySerializer.new(stats, each_serializer: PlayerStatSerializer).to_json
    end

    it do
      get :away_player_stats, id: game.id
      stats = game.away_team.players.map { |p| p.game_stat(game) }
      response.body.should == ActiveModel::ArraySerializer.new(stats, each_serializer: PlayerStatSerializer).to_json
    end

    it do
      get :home_team_players, id: game.id
      response.body.should == ActiveModel::ArraySerializer.new(game.home_team.players, each_serializer: PlayerSerializer).to_json
    end

    it do
      get :away_team_players, id: game.id
      response.body.should == ActiveModel::ArraySerializer.new(game.away_team.players, each_serializer: PlayerSerializer).to_json
    end

    after { response.status.should == 200 }
  end

  context "if game id is not existing" do
    it { get :home_team_stat,    id: game.id + 999 }
    it { get :home_player_stats, id: game.id + 999 }
    it { get :away_team_stat,    id: game.id + 999 }
    it { get :away_player_stats, id: game.id + 999 }
    after { response.status.should == 404 }
  end
end

describe GamesController, "POST add_home_team, add_away_team" do
  let(:home_team) { FactoryGirl.create(:complete_team) }
  let(:away_team) { FactoryGirl.create(:complete_team) }
  let(:game) { FactoryGirl.create(:game) }

  context "trying to add a team with less than 5 players" do
    let(:insufficient_team) { FactoryGirl.create(:team) }
    before { 4.times { insufficient_team.add_player(FactoryGirl.create(:player)) } }
    it "should fail" do
      post :add_home_team, id: game.id, team_id: insufficient_team.id
      response.status.should == 400
      response.body.should == { errors: 'team has less than 5 players' }.to_json
    end
  end

  it "should add a home team to a game" do
    post :add_home_team, id: game.id, team_id: home_team.id
    response.status.should == 200
    response.body.should == { success: true, message: 'a home team added to a game' }.to_json
    game.teams.should include(home_team)
    home_team.reload.current_game.should == game
  end

  context "when a game is not found" do
    it "should not add a team to a game" do
      post :add_home_team, id: game.id, team_id: 999
      response.status.should == 404
      game.teams.should be_empty
    end
  end

  context "when a game has two teams already" do
    before do
      post :add_home_team, id: game.id, team_id: home_team.id
      post :add_away_team, id: game.id, team_id: away_team.id
    end

    it "should not add a home team to a game" do
      post :add_home_team, id: game.id, team_id: home_team.id
      response.status.should == 400
      JSON.parse(response.body)["errors"].should == "game already has a home team"
    end

    it "should not add a away team to a game" do
      post :add_away_team, id: game.id, team_id: away_team.id
      response.status.should == 400
      JSON.parse(response.body)["errors"].should == "game already has an away team"
    end

  end
end

describe GamesController, "POST remove_team" do
  let(:team) { FactoryGirl.create(:team) }
  let(:game) { FactoryGirl.create(:game) }

  before { game.teams << team }

  it "should remove a team from a game" do
    post :remove_team, id: game.id, team_id: team.id
    response.status.should == 200
    response.body.should == { success: true, message: 'a team removed from a game' }.to_json
    game.teams.should_not include(team)
    game.reload.should_not be_nil
  end
end

describe GamesController, "POST start" do
  let(:home_team) { FactoryGirl.create(:complete_team) }
  let(:away_team) { FactoryGirl.create(:complete_team) }
  let(:game) { FactoryGirl.create(:game) }

  context "when two teams have beend added to a game" do
    before 'add 2 teams to game' do
      post :add_home_team, id: game.id, team_id: home_team.id
      post :add_away_team, id: game.id, team_id: away_team.id
    end

    it do
      post :start, id: game.id
      response.status.should == 200
      response.body.should == GameSerializer.new(game.reload).to_json
    end

    context "when game is already started" do
      before { post :start, id: game.id }

      it do
        post :start, id: game.id
        response.status.should == 400
        response.body.should == { errors: 'game is already in progress' }.to_json
      end
    end
  end

  context "when less than two teams are in a game" do
    before { post :add_home_team, id: game.id, team_id: FactoryGirl.create(:team).id }

    it do
      post :start, id: game.id
      response.status.should == 400
      response.body.should == { errors: 'game requires 2 teams to get started' }.to_json
    end
  end
end

describe GamesController, "POST finish" do
  let(:home_team) { FactoryGirl.create(:complete_team) }
  let(:away_team) { FactoryGirl.create(:complete_team) }
  let(:game) { FactoryGirl.create(:game) }

  before 'add 2 teams to game' do
    post :add_home_team, id: game.id, team_id: home_team.id
    post :add_away_team, id: game.id, team_id: away_team.id
  end

  context "when game is not started yet" do
    before { game.is_in_progress?.should be_false }
    it do
      post :finish, id: game.id
      response.status.should == 400
      response.body.should == { errors: 'game is not in progress' }.to_json
    end
  end

  context "when game is in progress" do
    before { post :start, id: game.id }

    it do
      post :finish, id: game.id
      response.status.should == 200
      response.body.should == GameSerializer.new(game.reload).to_json
    end

    after do
      post :restart, id: game.id
      response.status.should == 200
      response.body.should == GameSerializer.new(game.reload).to_json
    end
  end
end
