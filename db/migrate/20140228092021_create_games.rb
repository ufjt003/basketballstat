class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :gametime, null: false, default: DateTime.now

      t.timestamps
    end
  end
end
