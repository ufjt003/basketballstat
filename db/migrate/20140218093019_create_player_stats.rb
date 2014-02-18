class CreatePlayerStats < ActiveRecord::Migration
  def change
    create_table :player_stats do |t|
      t.integer :field_goal_attempted, null: false, default: 0
      t.integer :field_goal_made, null: false, default: 0
      t.integer :three_pointer_attempted, null: false, default: 0
      t.integer :three_pointer_made, null: false, default: 0
      t.integer :player_id

      t.timestamps
    end
  end
end
