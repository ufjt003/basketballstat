class Game < ActiveRecord::Base
  validates :gametime, presence: true

  has_many :teams

  def add_team(team)
    return unless teams.count < 2
    self.teams << team
    TeamStat.create(team_id: team.id, game_id: self.id)
    team.players.each { |player| PlayerStat.create(player_id: player.id, game_id: self.id) }
  end

  def remove_team(team)
    self.teams.delete(team)
    TeamStat.where(game_id: self.id, team_id: team.id).destroy_all
    PlayerStat.where(game_id: self.id, player_id: team.players).destroy_all
  end
end
