class Game < ActiveRecord::Base
  validates :gametime, presence: true
  after_destroy :reset_players_current_game
  after_destroy :reset_teams_current_game
  after_destroy :destroy_team_stat
  after_destroy :destroy_player_stat
  after_destroy :destroy_team_game
  after_destroy :destroy_game_player

  def teams
    team_ids = TeamGame.where(game_id: self.id).map(&:team_id)
    Team.where(id: team_ids)
  end

  def players
    player_ids = GamePlayer.where(game_id: self.id).map(&:player_id)
    Player.where(id: player_ids)
  end

  def add_home_team(team)
    error_if_already_has_a_home_team
    add_team(team, is_home_team: true)
  end

  def add_away_team(team)
    error_if_already_has_an_away_team
    add_team(team, is_home_team: false)
  end

  def remove_team(team)
    error_if_in_progress
    destroy_game_records(team)
    reset_current_game_id(team)
    remove_game_stats(team)
  end

  def start
    error_if_in_progress
    raise Errors::InvalidMethodCallError.new('game requires 2 teams to get started') unless has_two_teams?
    update_attributes(status: 'in_progress')
  end

  def finish
    raise Errors::InvalidMethodCallError.new('game is not in progress') unless is_in_progress?
    update_attributes(status: 'finished')
  end

  def restart
    raise Errors::InvalidMethodCallError.new('game is still in progress') if is_in_progress?
    update_attributes(status: 'in_progress')
  end

  def is_in_progress?
    self.status == 'in_progress'
  end

  def is_finished?
    self.status == 'finished'
  end

  def has_two_teams?
    self.teams.count == 2
  end

  def score
    return [] unless has_two_teams?
    [{home_team.name => home_team_score}, {away_team.name => away_team_score}]
  end

  def name
    "#{home_team.try(:name)} vs #{away_team.try(:name)}"
  end

  def home_team
    team_id = TeamGame.find_by(game_id: self.id, is_home_team: true).try(:team_id)
    Team.find_by_id(team_id)
  end

  def away_team
    team_id = TeamGame.find_by(game_id: self.id, is_home_team: false).try(:team_id)
    Team.find_by_id(team_id)
  end

  def home_team_score
    home_team.game_score(self) if home_team
  end

  def away_team_score
    away_team.game_score(self) if away_team
  end

  def home_player_stats
    home_team.players.map { |p| p.game_stat(self) } if home_team
  end

  def away_player_stats
    away_team.players.map { |p| p.game_stat(self) } if away_team
  end

  def player_stats
    home_player_stats.concat(away_player_stats).compact
  end

  def home_team_stat
    home_team.game_stat(self) if home_team
  end

  def away_team_stat
    away_team.game_stat(self) if away_team
  end

  def team_stats
    [home_team_stat, away_team_stat].compact
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

  def has_a_home_team?
    TeamGame.find_by(game_id: self.id, is_home_team: true).blank? == false
  end

  def has_an_away_team?
    TeamGame.find_by(game_id: self.id, is_home_team: false).blank? == false
  end

  def home_players_playing_in_game
    players_in_game & home_team.players
  end

  def away_players_playing_in_game
    players_in_game & away_team.players
  end

  def home_players_on_bench
    home_team.players - players_in_game
  end

  def away_players_on_bench
    away_team.players - players_in_game
  end

  def players_in_game
    player_ids = GamePlayer.where(game_id: self.id, in_game: true).map(&:player_id)
    Player.where(id: player_ids)
  end

  def players_on_bench
    player_ids = GamePlayer.where(game_id: self.id, in_game: false).map(&:player_id)
    Player.where(id: player_ids)
  end

  private

  def error_if_team_has_less_than_five_players(team)
    raise Errors::InvalidMethodCallError.new('team has less than 5 players') if team.players.count < 5
  end

  def error_if_in_progress
    raise Errors::InvalidMethodCallError.new('game is already in progress') if is_in_progress?
  end

  def error_if_already_has_a_home_team
    raise Errors::InvalidMethodCallError.new('game already has a home team') if has_a_home_team?
  end

  def error_if_already_has_an_away_team
    raise Errors::InvalidMethodCallError.new('game already has an away team') if has_an_away_team?
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

  def add_team(team, options = {})
    options.reverse_merge!(is_home_team: false)
    error_if_in_progress
    error_if_team_has_less_than_five_players(team)
    create_game_records(team, options[:is_home_team])
    set_current_game_id(team)
    create_game_stats(team)
  end

  def create_game_records(team, is_home_team = false)
    TeamGame.create!(team_id: team.id, game_id: self.id, is_home_team: is_home_team)
    team.players.each do |player|
      GamePlayer.create!(game_id: self.id, player_id: player.id)
    end
  end

  def set_current_game_id(team)
    team.update_attributes(game_id: self.id)
    team.players.each do |player|
      player.update_attributes(game_id: self.id)
    end
  end

  def destroy_game_player
    GamePlayer.where(game_id: self.id).destroy_all
  end

  def destroy_player_stat
    PlayerStat.where(game_id: self.id).destroy_all
  end

  def destroy_team_stat
    TeamStat.where(game_id: self.id).destroy_all
  end

  def destroy_team_game
    TeamGame.where(game_id: self.id).destroy_all
  end

  def reset_players_current_game
    self.players.each { |p| p.update_attributes(game_id: nil) }
  end

  def reset_teams_current_game
    self.teams.each { |t| t.update_attributes(game_id: nil) }
  end

  def reset_current_game_id(team)
    self.players.each do |player|
      player.update_attributes(game_id: nil)
    end
    team.update_attributes(game_id: nil)
  end

  def destroy_game_records(team)
    TeamGame.where(team_id: team.id, game_id: self.id).destroy_all
    GamePlayer.where(game_id: self.id, player_id: self.players.map(&:id)).destroy_all
  end

end
