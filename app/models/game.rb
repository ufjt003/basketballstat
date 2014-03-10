class Game < ActiveRecord::Base
  validates :gametime, presence: true

  has_many :teams
  has_many :players

  def add_team(team)
    error_if_in_progress
    error_if_game_already_has_two_teams
    error_if_team_has_less_than_five_players(team)
    self.teams << team
    self.players << team.players
    create_game_stats(team)
  end

  def remove_team(team)
    error_if_in_progress
    self.teams.delete(team)
    self.players.delete(team.players)
    remove_game_stats(team)
  end

  def start
    error_if_in_progress
    raise StandardError.new('game requires 2 teams to get started') unless has_two_teams?
    update_attributes(in_progress: true)
  end

  def finish
    raise StandardError.new('game is not in progress') unless is_in_progress?
    update_attributes(in_progress: false)
  end

  def is_in_progress?
    self.in_progress
  end

  def has_two_teams?
    self.teams.count == 2
  end

  private

  def error_if_game_already_has_two_teams
    raise StandardError.new('game already has 2 teams') if has_two_teams?
  end

  def error_if_team_has_less_than_five_players(team)
    raise StandardError.new('team has less than 5 players') if team.players.count < 5
  end

  def error_if_in_progress
    raise StandardError.new('game is already in progress') if is_in_progress?
  end

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
