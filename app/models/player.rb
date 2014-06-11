class Player < ActiveRecord::Base

  validates :name, presence: true

  after_create :create_all_time_stat

  has_one :all_time_stat, :foreign_key => 'player_id', :class_name => "AllTimePlayerStat"
  has_many :game_stats, :foreign_key => 'player_id', :class_name => 'PlayerStat'
  belongs_to :team
  belongs_to :current_game, :class_name => "Game", :foreign_key => "game_id"

  scope :not_in_a_team, -> { where(team_id: nil) }

  def two_pointer_attempt
    player_action(__method__)
  end

  def two_pointer_make
    player_action(__method__)
  end

  def three_pointer_attempt
    player_action(__method__)
  end

  def three_pointer_make
    player_action(__method__)
  end

  def free_throw_attempt
    player_action(__method__)
  end

  def free_throw_make
    player_action(__method__)
  end

  def assist
    player_action(__method__)
  end

  def block
    player_action(__method__)
  end

  def steal
    player_action(__method__)
  end

  def rebound
    player_action(__method__)
  end

  def turnover
    player_action(__method__)
  end

  def foul
    player_action(__method__)
  end

  def current_game_stat
    game_stat(self.current_game)
  end

  def game_stat(game)
    PlayerStat.find_by(game_id: game, player_id: self.id)
  end

  def in_a_team?
    self.team != nil
  end

  def serializable_hash(options)
    super(options.merge(except: [:updated_at, :created_at]))
  end

  def currently_in_a_game?
    self.current_game != nil
  end

  def enter_game(game)
    error_if_not_registered_in_game(game)
    error_if_playing_in_game(game)
    error_if_game_has_5_players_playing_for_a_team(game)
    GamePlayer.find_by(game_id: game.id, player_id: self.id).update_attributes(in_game: true)
    self.reload
  end

  def leave_game(game)
    raise Errors::InvalidMethodCallError.new("player #{self.name} is not playing in the game") unless game.players_in_game.include?(self)
    GamePlayer.find_by(game_id: game.id, player_id: self.id).update_attributes(in_game: false)
    self.reload
  end

  def is_playing_in_game?(game)
    return true if GamePlayer.find_by(game_id: game.id, player_id: self.id, in_game: true)
    false
  end

  private

  def error_if_game_has_5_players_playing_for_a_team(game)
    if self.team == game.away_team
      raise Errors::InvalidMethodCallError.new("away team already has 5 players playing") if game.away_players_playing_in_game.size == 5
    end

    if self.team == game.home_team
      raise Errors::InvalidMethodCallError.new("home team already has 5 players playing") if game.home_players_playing_in_game.size == 5
    end
  end

  def error_if_not_registered_in_game(game)
    raise Errors::InvalidMethodCallError.new("player #{self.name} is not registered in the game") unless game.players.include?(self)
  end

  def error_if_playing_in_game(game)
    raise Errors::InvalidMethodCallError.new("player #{self.name} is already playing in the game") if self.is_playing_in_game?(game)
  end

  def error_if_currently_not_in_a_game
    raise Errors::InvalidMethodCallError.new('player is currently not in a game') unless currently_in_a_game?
  end

  def error_if_current_game_is_not_in_progress
    raise Errors::InvalidMethodCallError.new("player's current game is not in progress") unless self.current_game.is_in_progress?
  end

  def player_action(action_name)
    error_if_currently_not_in_a_game
    error_if_current_game_is_not_in_progress
    self.all_time_stat.increment!(action_name)
    self.current_game_stat.try(:increment!, action_name)
    update_team_stat(action_name)
  end

  def create_all_time_stat
    AllTimePlayerStat.create(player_id: self.id)
  end

  def update_team_stat(play)
    if in_a_team?
      self.team.all_time_stat.increment!(play)
      self.team.current_game_stat.try(:increment!, play)
    end
  end
end
