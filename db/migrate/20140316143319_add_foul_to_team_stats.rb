class AddFoulToTeamStats < ActiveRecord::Migration
  def change
    add_column :team_stats, :foul, :integer, default: 0, null: false
  end
end
