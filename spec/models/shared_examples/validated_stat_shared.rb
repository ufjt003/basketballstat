require 'spec_helper'

shared_examples_for ValidatedStat do
  it { should validate_presence_of(:two_pointer_attempt) }
  it { should validate_presence_of(:two_pointer_make) }
  it { should validate_presence_of(:three_pointer_attempt) }
  it { should validate_presence_of(:three_pointer_make) }
  it { should validate_presence_of(:free_throw_attempt) }
  it { should validate_presence_of(:free_throw_make) }
  it { should validate_presence_of(:assist) }
  it { should validate_presence_of(:rebound) }
  it { should validate_presence_of(:steal) }
  it { should validate_presence_of(:block) }
  it { should validate_presence_of(:turnover) }
end

shared_examples "a stat" do |stat_type|
  let(:stat) { FactoryGirl.create(stat_type.to_sym, two_pointer_make: 1, three_pointer_make: 1, free_throw_make: 1) }
  it { stat.points.should == 6 }
end
