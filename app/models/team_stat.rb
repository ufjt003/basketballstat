class TeamStat < ActiveRecord::Base
  include StatValidator

  belongs_to :team

  def points
    2 * field_goal_made + 3 * three_pointer_made + free_throw_made
  end
end
