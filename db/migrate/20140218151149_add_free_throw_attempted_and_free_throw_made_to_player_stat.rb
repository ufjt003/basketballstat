class AddFreeThrowAttemptedAndFreeThrowMadeToPlayerStat < ActiveRecord::Migration
  def change
    add_column :player_stats, :free_throw_attempted, :integer, null: false, default: 0
    add_column :player_stats, :free_throw_made, :integer, null: false, default: 0
  end
end
