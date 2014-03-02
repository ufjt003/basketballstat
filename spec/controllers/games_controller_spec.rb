require 'spec_helper'

describe GamesController, "POST create" do
  it "should create a game" do
    expect {
      post :create, game: { gametime: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z") }
      response.status.should == 200
      response.body.should == { success: true, message: 'game created' }.to_json
    }.to change(Game, :count).by(1)
  end

  context "even when game time is not given" do
    it { expect {
      post :create, game: { wrong_params: "hey" }
      response.status.should == 200
      response.body.should == { success: true, message: 'game created' }.to_json
    }.to change(Game, :count).by(1) }
  end
end

describe GamesController, "GET show" do
  it "should return game info" do
    game = FactoryGirl.create(:game)
    get :show, id: game.id
    response.status.should == 200
    response.body.should == game.to_json
  end
end

describe GamesController, "POST add_team" do
  let(:team) { FactoryGirl.create(:team) }
  let(:game) { FactoryGirl.create(:game) }

  it "should add a team to a game" do
    post :add_team, id: game.id, team_id: team.id
    response.status.should == 200
    response.body.should == { success: true, message: 'a team added to a game' }.to_json
    game.teams.should include(team)
    team.reload.game.should == game
  end

  context "when a game is not found" do
    it "should not add a team to a game" do
      post :add_team, id: game.id, team_id: team.id + 1
      response.status.should == 400
      JSON.parse(response.body)["success"].should be_false
      game.teams.should be_empty
    end
  end

  context "when a game has two teams already" do
    let(:team_2) { FactoryGirl.create(:team) }
    let(:team_3) { FactoryGirl.create(:team) }

    before do
      post :add_team, id: game.id, team_id: team.id
      post :add_team, id: game.id, team_id: team_2.id
    end

    it "should not add a team to a game" do
      post :add_team, id: game.id, team_id: team_3.id
      response.status.should == 400
      JSON.parse(response.body)["success"].should be_false
      JSON.parse(response.body)["message"].should == "game has 2 teams already"
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
