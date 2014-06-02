class RemoveInProgressFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :in_progress, :boolean
  end
end
