class AddIsHomeTeamToTeamGames < ActiveRecord::Migration
  def change
    add_column :team_games, :is_home_team, :boolean, default: false, null: false
  end
end
