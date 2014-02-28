require 'spec_helper'

shared_examples_for StatValidator do
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

describe PlayerStat, "validations" do
  it_behaves_like StatValidator
end

describe PlayerStat, "relations" do
  it { should belong_to(:player) }
end
