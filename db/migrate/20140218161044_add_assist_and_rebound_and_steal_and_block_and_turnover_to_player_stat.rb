class AddAssistAndReboundAndStealAndBlockAndTurnoverToPlayerStat < ActiveRecord::Migration
  def change
    add_column :player_stats, :assist, :integer, null: false, default: 0
    add_column :player_stats, :rebound, :integer, null: false, default: 0
    add_column :player_stats, :steal, :integer, null: false, default: 0
    add_column :player_stats, :block, :integer, null: false, default: 0
    add_column :player_stats, :turnover, :integer, null: false, default: 0
  end
end
