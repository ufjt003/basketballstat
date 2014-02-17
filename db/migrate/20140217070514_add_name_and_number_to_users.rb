class AddNameAndNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :number, :integer
  end
end
