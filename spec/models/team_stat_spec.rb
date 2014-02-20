require 'spec_helper'

describe TeamStat, "validations" do
  it { should validate_presence_of(:field_goal_attempted) }
  it { should validate_presence_of(:field_goal_made) }
  it { should validate_presence_of(:three_pointer_attempted) }
  it { should validate_presence_of(:three_pointer_made) }
  it { should validate_presence_of(:free_throw_attempted) }
  it { should validate_presence_of(:free_throw_made) }
  it { should validate_presence_of(:assist) }
  it { should validate_presence_of(:rebound) }
  it { should validate_presence_of(:steal) }
  it { should validate_presence_of(:block) }
  it { should validate_presence_of(:turnover) }
end

describe TeamStat, "relations" do
  it { should belong_to(:team) }
end
