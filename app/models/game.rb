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
    TeamGame.create!(team_id: team.id, game_id: self.id)
  end

  def remove_team(team)
    error_if_in_progress
    self.teams.delete(team)
    self.players.delete(team.players)
    team.current_game = nil
    remove_game_stats(team)
    TeamGame.where(team_id: team.id, game_id: self.id).delete_all
  end

  def start
    error_if_in_progress
    raise Errors::InvalidMethodCallError.new('game requires 2 teams to get started') unless has_two_teams?
    update_attributes(in_progress: true)
  end

  def finish
    raise Errors::InvalidMethodCallError.new('game is not in progress') unless is_in_progress?
    update_attributes(in_progress: false)
  end

  def is_in_progress?
    self.in_progress
  end

  def has_two_teams?
    self.teams.count == 2
  end

  def score
    return [] unless has_two_teams?
    [{teams.first.name => teams.first.current_game_score}, {teams.last.name => teams.last.current_game_score}]
  end

  def home_team
    self.teams.first
  end

  def away_team
    self.teams.last
  end

  def home_team_score
    home_team.current_game_score
  end

  def away_team_score
    away_team.current_game_score
  end

  def serializable_hash(options)
    h = super(options.merge(except: [:updated_at, :created_at]))
    h.merge!(gametime: gametime.strftime("%Y-%m-%d %H:%M %z"))
    if has_two_teams?
      h.merge!(home_team: home_team.name, home_team_score: home_team_score)
      h.merge!(away_team: away_team.name, away_team_score: away_team_score)
    end
    h
  end

  private

  def error_if_game_already_has_two_teams
    raise Errors::InvalidMethodCallError.new('game already has 2 teams') if has_two_teams?
  end

  def error_if_team_has_less_than_five_players(team)
    raise Errors::InvalidMethodCallError.new('team has less than 5 players') if team.players.count < 5
  end

  def error_if_in_progress
    raise Errors::InvalidMethodCallError.new('game is already in progress') if is_in_progress?
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
