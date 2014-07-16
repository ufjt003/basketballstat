require 'spec_helper'

describe GamesController do
  it { { post: 'api/games' }.should route_to(controller: "games", action: "create") }
  it { { get:  'api/games' }.should route_to(controller: "games", action: "index") }
  it { { get:  'api/games/1' }.should route_to(controller: "games", action: "show", id: "1") }
  it { { get:  'api/games/1/home_team_stat' }.should route_to(controller: "games", action: "home_team_stat", id: "1") }
  it { { get:  'api/games/1/away_team_stat' }.should route_to(controller: "games", action: "away_team_stat", id: "1") }
  it { { get:  'api/games/1/home_player_stats' }.should route_to(controller: "games", action: "home_player_stats", id: "1") }
  it { { get:  'api/games/1/away_player_stats' }.should route_to(controller: "games", action: "away_player_stats", id: "1") }
  it { { delete:  'api/games/1' }.should route_to(controller: "games", action: "destroy", id: "1") }
  it { { post: 'api/games/1/add_home_team/2' }.should route_to(controller: "games", action: "add_home_team", id: "1", team_id: "2") }
  it { { post: 'api/games/1/add_away_team/2' }.should route_to(controller: "games", action: "add_away_team", id: "1", team_id: "2") }
  it { { post: 'api/games/1/remove_team/2' }.should route_to(controller: "games", action: "remove_team", id: "1", team_id: "2") }
  it { { put: 'api/games/1/start' }.should route_to(controller: "games", action: "start", id: "1") }
  it { { put: 'api/games/1/finish' }.should route_to(controller: "games", action: "finish", id: "1") }
  it { { put: 'api/games/1/restart' }.should route_to(controller: "games", action: "restart", id: "1") }
  it { { get: 'api/games/1/home_team_players' }.should route_to(controller: "games", action: "home_team_players", id: "1") }
  it { { get: 'api/games/1/away_team_players' }.should route_to(controller: "games", action: "away_team_players", id: "1") }
  it { { get: 'api/games/1/players' }.should route_to(controller: "games", action: "players", id: "1") }
  it { { put: 'api/games/1/player_entry/2' }.should route_to(controller: "games", action: "player_entry", id: "1", player_id: "2") }
  it { { put: 'api/games/1/player_leave/2' }.should route_to(controller: "games", action: "player_leave", id: "1", player_id: "2") }
end
