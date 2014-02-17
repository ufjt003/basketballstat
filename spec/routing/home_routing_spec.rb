require 'spec_helper'

describe HomeController do
  it { { get: '/' }.should route_to(controller: "home", action: "index") }
end
