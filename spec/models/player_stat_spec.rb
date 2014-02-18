require 'spec_helper'

describe PlayerStat, "validations" do
  it { should validate_presence_of(:field_goal_attempted) }
  it { should validate_presence_of(:field_goal_made) }
  it { should validate_presence_of(:three_pointer_attempted) }
  it { should validate_presence_of(:three_pointer_made) }
end

describe PlayerStat, "relations" do
  it { should belong_to(:player) }
end
