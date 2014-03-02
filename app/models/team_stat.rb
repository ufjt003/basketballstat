class TeamStat < ActiveRecord::Base
  include ValidatedStat

  belongs_to :team
  belongs_to :game

  def points
    2 * field_goal_made + 3 * three_pointer_made + free_throw_made
  end
end
