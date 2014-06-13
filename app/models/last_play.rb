class LastPlay < ActiveRecord::Base
  validates_uniqueness_of :game_id
end
