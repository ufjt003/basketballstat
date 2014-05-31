class CreateTeamGames < ActiveRecord::Migration
  def change
    create_table :team_games do |t|
      t.integer :team_id
      t.integer :game_id

      t.timestamps
    end
  end
end
