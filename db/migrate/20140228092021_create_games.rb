class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :gametime, null: false

      t.timestamps
    end
  end
end
