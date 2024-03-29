require 'spec_helper'

describe PlayersController do
  it { { post: 'api/players' }.should route_to(controller: "players", action: "create") }
  it { { get:  'api/players' }.should route_to(controller: "players", action: "index") }
  it { { get:  'api/players/not_in_a_team' }.should route_to(controller: "players", action: "not_in_a_team") }
  it { { get:  'api/players/1' }.should route_to(controller: "players", action: "show", id: "1") }
  it { { put: 'api/players/1/two_pointer_attempt' }.should route_to(controller: "players", action: "two_pointer_attempt", id: "1") }
  it { { put: 'api/players/1/two_pointer_make' }.should route_to(controller: "players", action: "two_pointer_make", id: "1") }
  it { { put: 'api/players/1/three_pointer_attempt' }.should route_to(controller: "players", action: "three_pointer_attempt", id: "1") }
  it { { put: 'api/players/1/three_pointer_make' }.should route_to(controller: "players", action: "three_pointer_make", id: "1") }
  it { { put: 'api/players/1/free_throw_attempt' }.should route_to(controller: "players", action: "free_throw_attempt", id: "1") }
  it { { put: 'api/players/1/free_throw_make' }.should route_to(controller: "players", action: "free_throw_make", id: "1") }
  it { { put: 'api/players/1/assist' }.should route_to(controller: "players", action: "assist", id: "1") }
  it { { put: 'api/players/1/rebound' }.should route_to(controller: "players", action: "rebound", id: "1") }
  it { { put: 'api/players/1/steal' }.should route_to(controller: "players", action: "steal", id: "1") }
  it { { put: 'api/players/1/block' }.should route_to(controller: "players", action: "block", id: "1") }
  it { { put: 'api/players/1/turnover' }.should route_to(controller: "players", action: "turnover", id: "1") }
  it { { put: 'api/players/1/foul' }.should route_to(controller: "players", action: "foul", id: "1") }
  it { { put: 'api/players/1/undo' }.should route_to(controller: "players", action: "undo", id: "1") }
end
