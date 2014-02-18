require 'spec_helper'

describe PlayersController, "POST create" do
  it "should create a player" do
    expect {
      post :create, player: { name: "steve nash", number: 10 }
      response.status.should == 200
      response.body.should == { success: true, message: 'player created' }.to_json
    }.to change(Player, :count).by(1)
  end
end
