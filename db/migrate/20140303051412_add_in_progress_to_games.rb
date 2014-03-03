class AddInProgressToGames < ActiveRecord::Migration
  def change
    add_column :games, :in_progress, :boolean, null: false, default: false
  end
end
