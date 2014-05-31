require 'spec_helper'

describe TeamGame do
  it { should validate_presence_of(:team_id) }
  it { should validate_presence_of(:game_id) }
  it { should validate_uniqueness_of(:game_id).scoped_to(:team_id) }
end
