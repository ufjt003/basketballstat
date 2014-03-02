class AddGameIdToTeamStat < ActiveRecord::Migration
  def change
    add_column :team_stats, :game_id, :integer
  end
end
