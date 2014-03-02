class CreateAllTimePlayerStats < ActiveRecord::Migration
  def change
    create_table :all_time_player_stats do |t|
      t.integer :player_id
      t.integer :field_goal_attempted, default: 0, null: false
      t.integer :field_goal_made, default: 0, null: false
      t.integer :three_pointer_attempted, default: 0, null: false
      t.integer :three_pointer_made, default: 0, null: false
      t.integer :free_throw_attempted, default: 0, null: false
      t.integer :free_throw_made, default: 0, null: false
      t.integer :assist, default: 0, null: false
      t.integer :rebound, default: 0, null: false
      t.integer :steal, default: 0, null: false
      t.integer :block, default: 0, null: false
      t.integer :turnover, default: 0, null: false

      t.timestamps
    end
  end
end
