class PlayerStat < ActiveRecord::Base
  include ValidatedStat
  include StatMethods

  belongs_to :player
  belongs_to :game

end
