require 'spec_helper'

describe TeamStat, "validations" do
  it_behaves_like StatValidator
end

describe TeamStat, "relations" do
  it { should belong_to(:team) }
end
