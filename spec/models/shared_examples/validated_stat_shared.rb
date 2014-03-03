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
  let(:stat) { FactoryGirl.create(stat_type.to_sym,
                                  two_pointer_make: 1, two_pointer_attempt: 2,
                                  three_pointer_make: 1, three_pointer_attempt: 2,
                                  free_throw_make: 1, free_throw_attempt: 2) }
  it { stat.points.should == 2 * stat.two_pointer_make + 3 * stat.three_pointer_make + stat.free_throw_make }
  it { stat.field_goal_attempt.should == stat.two_pointer_attempt + stat.three_pointer_attempt }
  it { stat.field_goal_make.should == stat.two_pointer_make + stat.three_pointer_make }
  it { stat.field_goal_percentage.should == stat.field_goal_make.to_f / stat.field_goal_attempt }
  it { stat.three_pointer_percentage.should == stat.three_pointer_make.to_f / stat.three_pointer_attempt }
  it { stat.free_throw_percentage.should == stat.free_throw_make.to_f / stat.free_throw_attempt }
end
