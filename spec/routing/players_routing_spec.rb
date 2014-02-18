require 'spec_helper'

describe PlayersController do
  it { { post: 'players' }.should route_to(controller: "players", action: "create") }
  it { { get: 'players/1' }.should route_to(controller: "players", action: "show", id: "1") }
  it { { post: 'players/1/shoots' }.should route_to(controller: "players", action: "shoots", id: "1") }
  it { { post: 'players/1/makes_field_goal' }.should route_to(controller: "players", action: "makes_field_goal", id: "1") }
  it { { post: 'players/1/shoots_three_pointer' }.should route_to(controller: "players", action: "shoots_three_pointer", id: "1") }
  it { { post: 'players/1/makes_three_pointer' }.should route_to(controller: "players", action: "makes_three_pointer", id: "1") }
  it { { post: 'players/1/shoots_free_throw' }.should route_to(controller: "players", action: "shoots_free_throw", id: "1") }
  it { { post: 'players/1/makes_free_throw' }.should route_to(controller: "players", action: "makes_free_throw", id: "1") }
  it { { post: 'players/1/assist' }.should route_to(controller: "players", action: "assist", id: "1") }
  it { { post: 'players/1/rebound' }.should route_to(controller: "players", action: "rebound", id: "1") }
  it { { post: 'players/1/steal' }.should route_to(controller: "players", action: "steal", id: "1") }
  it { { post: 'players/1/block' }.should route_to(controller: "players", action: "block", id: "1") }
  it { { post: 'players/1/turnover' }.should route_to(controller: "players", action: "turnover", id: "1") }
end
