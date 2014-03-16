class AddFoulToPlayerStats < ActiveRecord::Migration
  def change
    add_column :player_stats, :foul, :integer, default: 0, null: false
  end
end
