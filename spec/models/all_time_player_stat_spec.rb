require 'spec_helper'

describe AllTimePlayerStat do
  it_behaves_like ValidatedStat
  it { should belong_to(:player) }
  it_behaves_like "a stat", :all_time_player_stat
end
