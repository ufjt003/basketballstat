require 'spec_helper'

describe TeamsController do
  it { { post: 'teams' }.should route_to(controller: "teams", action: "create") }
  it { { get: 'teams/1' }.should route_to(controller: "teams", action: "show", id: "1") }
end
