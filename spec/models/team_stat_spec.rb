require 'spec_helper'

describe TeamStat do
  it_behaves_like StatValidator
  it { should belong_to(:team) }
  it_behaves_like "a stat", :team_stat
end
