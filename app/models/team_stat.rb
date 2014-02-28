class TeamStat < ActiveRecord::Base
  include StatValidator

  belongs_to :team
end
