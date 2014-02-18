class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, null: false, default: ""
      t.integer :number

      t.timestamps
    end
  end
end
