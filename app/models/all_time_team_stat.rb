class AllTimeTeamStat < ActiveRecord::Base
  include ValidatedStat
  include StatMethods

  belongs_to :team
end
