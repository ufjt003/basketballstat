class Team < ActiveRecord::Base

  validates :name, presence: true

  has_many :players
  has_one :all_time_stat, :foreign_key => 'team_id', :class_name => "AllTimeTeamStat"
  belongs_to :current_game, :class_name => "Game", :foreign_key => "game_id"

  after_create :create_all_time_stat

  def add_player(player)
    raise Errors::InvalidMethodCallError.new("player #{player.name} already in the team") if self.players.include?(player)
    self.players << player
  end

  def remove_player(player)
    raise Errors::InvalidMethodCallError.new("player #{player.name} not in the team") unless self.players.include?(player)
    self.players.delete(player)
  end

  def game_stat
    TeamStat.find_by(game_id: self.current_game, team_id: self.id) if self.currently_in_a_game?
  end

  def game_score
    game_stat.try(:points)
  end

  def currently_in_a_game?
    self.current_game != nil
  end

  def serializable_hash(options)
    super(options.merge(except: [:updated_at, :created_at]))
  end

  private

  def create_all_time_stat
    AllTimeTeamStat.create(team_id: self.id)
  end

end
