require 'spec_helper'

describe GamesController, "POST create" do
  let(:team_with_5_players) { FactoryGirl.create(:complete_team) }
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
      post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") }, home_team_id: team_with_5_players.id
      response.status.should == 200
      response.body.should == GameSerializer.new(Game.last).to_json
      teams = Game.last.teams
      teams.size.should == 1
    }.to change(Game, :count).by(1) }
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

describe GamesController, "POST add_team" do
  let(:team) { FactoryGirl.create(:team) }
  let(:team2) { FactoryGirl.create(:team) }
  let(:game) { FactoryGirl.create(:game) }

  before { 5.times { team.add_player(FactoryGirl.create(:player)) } }
  before { 5.times { team2.add_player(FactoryGirl.create(:player)) } }

  context "trying to add a team with less than 5 players" do
    let(:insufficient_team) { FactoryGirl.create(:team) }
    before { 4.times { insufficient_team.add_player(FactoryGirl.create(:player)) } }
    it "should fail" do
      post :add_team, id: game.id, team_id: insufficient_team.id
      response.status.should == 400
      response.body.should == { success: false, message: 'team has less than 5 players' }.to_json
    end
  end

  it "should add a team to a game" do
    post :add_team, id: game.id, team_id: team.id
    response.status.should == 200
    response.body.should == { success: true, message: 'a team added to a game' }.to_json
    game.teams.should include(team)
    team.reload.game.should == game
  end

  context "when a game is not found" do
    it "should not add a team to a game" do
      post :add_team, id: game.id, team_id: 999
      response.status.should == 404
      JSON.parse(response.body)["success"].should be_false
      game.teams.should be_empty
    end
  end

  context "when a game has two teams already" do
    before do
      post :add_team, id: game.id, team_id: team.id
      post :add_team, id: game.id, team_id: team2.id
    end

    it "should not add a team to a game" do
      post :add_team, id: game.id, team_id: team.id
      response.status.should == 400
      JSON.parse(response.body)["success"].should be_false
      JSON.parse(response.body)["message"].should == "game already has 2 teams"
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
  let(:team) { FactoryGirl.create(:team) }
  let(:team2) { FactoryGirl.create(:team) }
  let(:game) { FactoryGirl.create(:game) }

  before { 5.times { team.add_player(FactoryGirl.create(:player)) } }
  before { 5.times { team2.add_player(FactoryGirl.create(:player)) } }

  context "when two teams have beend added to a game" do
    before 'add 2 teams to game' do
      post :add_team, id: game.id, team_id: team.id
      post :add_team, id: game.id, team_id: team2.id
    end

    it do
      post :start, id: game.id
      response.status.should == 200
      response.body.should == { success: true, message: 'game started' }.to_json
    end

    context "when game is already started" do
      before { post :start, id: game.id }

      it do
        post :start, id: game.id
        response.status.should == 400
        response.body.should == { success: false, message: 'game is already in progress' }.to_json
      end
    end
  end

  context "when less than two teams are in a game" do
    before { post :add_team, id: game.id, team_id: FactoryGirl.create(:team).id }

    it do
      post :start, id: game.id
      response.status.should == 400
      response.body.should == { success: false, message: 'game requires 2 teams to get started' }.to_json
    end
  end
end

describe GamesController, "POST finish" do
  let(:team) { FactoryGirl.create(:team) }
  let(:team2) { FactoryGirl.create(:team) }
  let(:game) { FactoryGirl.create(:game) }

  before { 5.times { team.add_player(FactoryGirl.create(:player)) } }
  before { 5.times { team2.add_player(FactoryGirl.create(:player)) } }

  before 'add 2 teams to game' do
    post :add_team, id: game.id, team_id: team.id
    post :add_team, id: game.id, team_id: team2.id
  end

  context "when game is not started yet" do
    before { game.is_in_progress?.should be_false }
    it do
      post :finish, id: game.id
      response.status.should == 400
      response.body.should == { success: false, message: 'game is not in progress' }.to_json
    end
  end

  context "when game is in progress" do
    before { post :start, id: game.id }

    it do
      post :finish, id: game.id
      response.status.should == 200
      response.body.should == { success: true, message: 'game finished' }.to_json
    end
  end
end

