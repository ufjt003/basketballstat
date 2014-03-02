class Game < ActiveRecord::Base
  validates :gametime, presence: true

  has_many :teams
  has_many :players

  def add_team(team)
    return if self.teams.count >= 2
    self.teams << team
    self.players << team.players
    create_game_stats(team)
  end

  def remove_team(team)
    self.teams.delete(team)
    self.players.delete(team.players)
    remove_game_stats(team)
  end

  private

  def create_game_stats(team)
    TeamStat.create(team_id: team.id, game_id: self.id)
    team.players.each do |player|
      PlayerStat.create(player_id: player.id, game_id: self.id)
    end
  end

  def remove_game_stats(team)
    TeamStat.where(game_id: self.id, team_id: team.id).destroy_all
    PlayerStat.where(game_id: self.id, player_id: team.players).destroy_all
  end
end
