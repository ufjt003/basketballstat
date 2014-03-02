class TeamStat < ActiveRecord::Base
  include ValidatedStat
  include StatMethods

  belongs_to :team
  belongs_to :game

end
