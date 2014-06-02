class AddStatusToGames < ActiveRecord::Migration
  def change
    add_column :games, :status, :string, null: false, default: "not_started"
  end
end
