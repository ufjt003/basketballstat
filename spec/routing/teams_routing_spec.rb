require 'spec_helper'

describe TeamsController do
  it { { post: 'teams' }.should route_to(controller: "teams", action: "create") }
  it { { get: 'teams/1' }.should route_to(controller: "teams", action: "show", id: "1") }
  it { { post: 'teams/1/add_player/2' }.should route_to(controller: "teams", action: "add_player", id: "1", player_id: "2") }
  it { { post: 'teams/1/remove_player/2' }.should route_to(controller: "teams", action: "remove_player", id: "1", player_id: "2") }
end
