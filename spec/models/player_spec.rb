require 'spec_helper'

describe Player do
  it { should validate_presence_of(:name) }
end
