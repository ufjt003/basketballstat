class CreateLastPlays < ActiveRecord::Migration
  def change
    create_table :last_plays do |t|
      t.integer :player_id
      t.integer :game_id
      t.string :action

      t.timestamps
    end
  end
end
