require 'spec_helper'

describe GamePlayer do
  it { should validate_presence_of(:game_id) }
  it { should validate_presence_of(:player_id) }
  it { should validate_uniqueness_of(:player_id).scoped_to(:game_id) }
end
