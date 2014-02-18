class PlayerStat < ActiveRecord::Base
  validates :field_goal_attempted, presence: true
  validates :field_goal_made, presence: true
  validates :three_pointer_attempted, presence: true
  validates :three_pointer_made, presence: true

  belongs_to :player
end
