class AddFoulToAllTimeTeamStats < ActiveRecord::Migration
  def change
    add_column :all_time_team_stats, :foul, :integer, default: 0, null: false
  end
end
