require 'spec_helper'

describe LastPlay do
  it { should validate_uniqueness_of(:game_id) }
end
