class AddInGameToGamePlayers < ActiveRecord::Migration
  def change
    add_column :game_players, :in_game, :boolean, null: false, default: false
  end
end
