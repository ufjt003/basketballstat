class AddGameIdToPlayerStat < ActiveRecord::Migration
  def change
    add_column :player_stats, :game_id, :integer
  end
end
