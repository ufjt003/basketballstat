class TeamStat < ActiveRecord::Base
  include ValidatedStat
  include StatMethods

  belongs_to :team
  belongs_to :game

  validates_uniqueness_of :team_id, :scope => :game_id
end
