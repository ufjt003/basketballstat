class Player < ActiveRecord::Base

  validates :name, presence: true

  after_create :create_all_time_stat

  has_one :all_time_stat, :foreign_key => 'player_id', :class_name => "AllTimePlayerStat"
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

  def game_stat
    PlayerStat.find_by(game_id: self.current_game, player_id: self.id) if currently_in_a_game?
  end

  def currently_in_a_game?
    self.current_game != nil
  end

  def in_a_team?
    self.team != nil
  end

  def serializable_hash(options)
    super(options.merge(except: [:updated_at, :created_at]))
  end

  private

  def player_action(action_name)
    self.all_time_stat.increment!(action_name)
    self.game_stat.try(:increment!, action_name)
    update_team_stat(action_name)
  end

  def create_all_time_stat
    AllTimePlayerStat.create(player_id: self.id)
  end

  def update_team_stat(play)
    if in_a_team?
      self.team.all_time_stat.increment!(play)
      self.team.game_stat.try(:increment!, play)
    end
  end
end
