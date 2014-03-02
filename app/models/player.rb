class Player < ActiveRecord::Base

  validates :name, presence: true

  after_create :create_all_time_stat

  has_one :all_time_stat, :foreign_key => 'player_id', :class_name => "AllTimePlayerStat"
  belongs_to :team
  belongs_to :game

  def two_pointer_attempt
    self.all_time_stat.increment!(:two_pointer_attempt)
    self.game_stat.try(:increment!, :two_pointer_attempt)
    update_team_stat(:two_pointer_attempt)
  end

  def two_pointer_make
    self.all_time_stat.increment!(:two_pointer_make)
    self.game_stat.try(:increment!, :two_pointer_make)
    update_team_stat(:two_pointer_make)
  end

  def three_pointer_attempt
    self.all_time_stat.increment!(:three_pointer_attempt)
    self.game_stat.try(:increment!, :three_pointer_attempt)
    update_team_stat(:three_pointer_attempt)
  end

  def three_pointer_make
    self.all_time_stat.increment!(:three_pointer_make)
    self.game_stat.try(:increment!, :three_pointer_make)
    update_team_stat(:three_pointer_make)
  end

  def free_throw_attempt
    self.all_time_stat.increment!(:free_throw_attempt)
    self.game_stat.try(:increment!, :free_throw_attempt)
    update_team_stat(:free_throw_attempt)
  end

  def free_throw_make
    self.all_time_stat.increment!(:free_throw_make)
    self.game_stat.try(:increment!, :free_throw_make)
    update_team_stat(:free_throw_make)
  end

  def assist
    self.all_time_stat.increment!(:assist)
    self.game_stat.try(:increment!, :assist)
    update_team_stat(:assist)
  end

  def block
    self.all_time_stat.increment!(:block)
    self.game_stat.try(:increment!, :block)
    update_team_stat(:block)
  end

  def steal
    self.all_time_stat.increment!(:steal)
    self.game_stat.try(:increment!, :steal)
    update_team_stat(:steal)
  end

  def rebound
    self.all_time_stat.increment!(:rebound)
    self.game_stat.try(:increment!, :rebound)
    update_team_stat(:rebound)
  end

  def turnover
    self.all_time_stat.increment!(:turnover)
    self.game_stat.try(:increment!, :turnover)
    update_team_stat(:turnover)
  end

  def game_stat
    PlayerStat.find_by(game_id: self.game, player_id: self.id) if in_a_game?
  end

  def in_a_game?
    self.game != nil
  end

  def in_a_team?
    self.team != nil
  end

  private

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
