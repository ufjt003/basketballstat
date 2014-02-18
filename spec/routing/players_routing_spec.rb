require 'spec_helper'

describe PlayersController do
  it { { post: 'players' }.should route_to(controller: "players", action: "create") }
  it { { get: 'players/1' }.should route_to(controller: "players", action: "show", id: "1") }
  it { { post: 'players/1/shoots' }.should route_to(controller: "players", action: "shoots", id: "1") }
  it { { post: 'players/1/makes_field_goal' }.should route_to(controller: "players", action: "makes_field_goal", id: "1") }
end
