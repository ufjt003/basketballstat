require 'spec_helper'

describe GamesController do
  it { { post: 'games' }.should route_to(controller: "games", action: "create") }
  it { { get:  'games/1' }.should route_to(controller: "games", action: "show", id: "1") }
  it { { post: 'games/1/add_team/2' }.should route_to(controller: "games", action: "add_team", id: "1", team_id: "2") }
  it { { post: 'games/1/remove_team/2' }.should route_to(controller: "games", action: "remove_team", id: "1", team_id: "2") }
end
