class Team < ActiveRecord::Base

  validates :name, presence: true

  has_many :players
  has_one :all_time_stat, :foreign_key => 'team_id', :class_name => "AllTimeTeamStat"
  has_many :game_stats, :foreign_key => 'team_id', :class_name => 'TeamStat'
  belongs_to :current_game, :class_name => "Game", :foreign_key => "game_id"

  after_create :create_all_time_stat
  before_destroy :check_if_in_a_game
  after_destroy :reset_player_team

  def reset_player_team
    self.players.each { |p| p.update_attributes(team_id: nil) }
  end

  def check_if_in_a_game
    raise Errors::InvalidMethodCallError.new("team #{self.name} already in a game #{self.current_game.id}") if self.currently_in_a_game?
  end

  def games
    game_ids = TeamGame.select(:game_id).where(team_id: self.id).map(&:game_id)
    Game.where(id: game_ids)
  end

  def add_player(player)
    error_if_currently_playing_in_a_game
    raise Errors::InvalidMethodCallError.new("player #{player.name} already in the team") if self.players.include?(player)
    self.players << player
  end

  def remove_player(player)
    error_if_currently_playing_in_a_game
    raise Errors::InvalidMethodCallError.new("player #{player.name} not in the team") unless self.players.include?(player)
    self.players.delete(player)
  end

  def current_game_stat
    game_stat(self.current_game)
  end

  def game_stat(game)
    TeamStat.find_by(game_id: game, team_id: self.id)
  end

  def current_game_score
    current_game_stat.try(:points)
  end

  def game_score(game)
    game_stat(game).try(:points)
  end

  def currently_in_a_game?
    self.current_game != nil
  end

  def currently_playing_in_a_game?
    self.current_game != nil and self.current_game.is_in_progress?
  end

  def serializable_hash(options)
    super(options.merge(except: [:updated_at, :created_at]))
  end

  private

  def create_all_time_stat
    AllTimeTeamStat.create(team_id: self.id)
  end

  def error_if_currently_playing_in_a_game
    raise Errors::InvalidMethodCallError.new("team #{self.name} currently playing in a game") if self.currently_playing_in_a_game?
  end


end
