require 'spec_helper'

describe PlayersController do
  it { { post: 'players' }.should route_to(controller: "players", action: "create") }
end
