class PlayerStat < ActiveRecord::Base
  include StatValidator

  belongs_to :player
end
