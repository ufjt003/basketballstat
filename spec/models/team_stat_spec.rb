require 'spec_helper'

describe TeamStat do
  it_behaves_like ValidatedStat
  it { should belong_to(:team) }
  it { should belong_to(:game) }
  it { should validate_uniqueness_of(:team_id).scoped_to(:game_id) }
  it_behaves_like "a stat", :team_stat
end
