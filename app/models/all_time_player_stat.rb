class AllTimePlayerStat < ActiveRecord::Base
  include ValidatedStat
  include StatMethods

  belongs_to :player

end
