require 'spec_helper'

describe AllTimeTeamStat do
  it_behaves_like ValidatedStat
  it { should belong_to(:team) }
  it_behaves_like "a stat", :all_time_team_stat
end
