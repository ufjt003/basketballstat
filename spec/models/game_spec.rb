require 'spec_helper'

describe Game do
  it { should validate_presence_of(:gametime) }
  it { should have_many(:teams) }
end
