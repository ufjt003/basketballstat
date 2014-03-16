class AddFoulToAllTimePlayerStats < ActiveRecord::Migration
  def change
    add_column :all_time_player_stats, :foul, :integer, default: 0, null: false
  end
end
