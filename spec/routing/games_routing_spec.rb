require 'spec_helper'

describe GamesController do
  it { { post: 'api/games' }.should route_to(controller: "games", action: "create") }
  it { { get:  'api/games' }.should route_to(controller: "games", action: "index") }
  it { { get:  'api/games/1' }.should route_to(controller: "games", action: "show", id: "1") }
  it { { delete:  'api/games/1' }.should route_to(controller: "games", action: "destroy", id: "1") }
  it { { post: 'api/games/1/add_home_team/2' }.should route_to(controller: "games", action: "add_home_team", id: "1", team_id: "2") }
  it { { post: 'api/games/1/add_away_team/2' }.should route_to(controller: "games", action: "add_away_team", id: "1", team_id: "2") }
  it { { post: 'api/games/1/remove_team/2' }.should route_to(controller: "games", action: "remove_team", id: "1", team_id: "2") }
  it { { post: 'api/games/1/start' }.should route_to(controller: "games", action: "start", id: "1") }
  it { { post: 'api/games/1/finish' }.should route_to(controller: "games", action: "finish", id: "1") }
end
