require 'spec_helper'

describe PlayerStat do
  it_behaves_like ValidatedStat
  it { should belong_to(:player) }
  it { should belong_to(:game) }
  it_behaves_like "a stat", :player_stat
end
