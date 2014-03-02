require 'spec_helper'

describe PlayerStat do
  it_behaves_like ValidatedStat
  it { should belong_to(:player) }
  it { should belong_to(:game) }
  it { should validate_uniqueness_of(:player_id).scoped_to(:game_id) }
  it_behaves_like "a stat", :player_stat
end
