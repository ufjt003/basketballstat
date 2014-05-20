class Team < ActiveRecord::Base

  validates :name, presence: true

  has_many :players
  has_one :all_time_stat, :foreign_key => 'team_id', :class_name => "AllTimeTeamStat"
  belongs_to :game

  after_create :create_all_time_stat

  def add_player(player)
    raise StandardError.new("player #{player.name} already in the team") if self.players.include?(player)
    self.players << player
  end

  def remove_player(player)
    raise StandardError.new("player #{player.name} not in the team") unless self.players.include?(player)
    self.players.delete(player)
  end

  def game_stat
    TeamStat.find_by(game_id: self.game, team_id: self.id) if self.in_a_game?
  end

  def game_score
    game_stat.try(:points)
  end

  def in_a_game?
    self.game != nil
  end

  def serializable_hash(options)
    super(options.merge(except: [:updated_at, :created_at]))
  end

  private

  def create_all_time_stat
    AllTimeTeamStat.create(team_id: self.id)
  end

end
