require 'spec_helper'

describe Team do
  it { should validate_presence_of(:name) }
  it { should have_many(:players) }
end
