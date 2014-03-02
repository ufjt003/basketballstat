class RenameColumnsInTeamStats < ActiveRecord::Migration
  def change
    rename_column :team_stats, :field_goal_attempted, :two_pointer_attempt
    rename_column :team_stats, :field_goal_made, :two_pointer_make
    rename_column :team_stats, :three_pointer_attempted, :three_pointer_attempt
    rename_column :team_stats, :three_pointer_made, :three_pointer_make
    rename_column :team_stats, :free_throw_attempted, :free_throw_attempt
    rename_column :team_stats, :free_throw_made, :free_throw_make
  end
end
