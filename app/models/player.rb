class Player < ActiveRecord::Base

  validates :name, presence: true

  after_create :create_all_time_stat

  has_one :all_time_stat, :foreign_key => 'player_id', :class_name => "AllTimePlayerStat"
  belongs_to :team
  belongs_to :game

  def shoot
    self.all_time_stat.increment!(:field_goal_attempted)
    self.game_stat.try(:increment!, :field_goal_attempted)
    if in_a_team?
      self.team.all_time_stat.increment!(:field_goal_attempted)
      self.team.game_stat.try(:increment!, :field_goal_attempted)
    end
  end

  def make_field_goal
    self.all_time_stat.increment!(:field_goal_made)
    self.game_stat.try(:increment!, :field_goal_made)
    if in_a_team?
      self.team.all_time_stat.increment!(:field_goal_made)
      self.team.game_stat.try(:increment!, :field_goal_made)
    end
  end

  def shoot_three_pointer
    self.all_time_stat.increment!(:three_pointer_attempted)
    self.game_stat.try(:increment!, :three_pointer_attempted)
    if in_a_team?
      self.team.all_time_stat.increment!(:three_pointer_attempted)
      self.team.game_stat.try(:increment!, :three_pointer_attempted)
    end
  end

  def make_three_pointer
    self.all_time_stat.increment!(:three_pointer_made)
    self.game_stat.try(:increment!, :three_pointe_made)
    if in_a_team?
      self.team.all_time_stat.increment!(:three_pointer_made)
      self.team.game_stat.try(:increment!, :three_pointer_made)
    end
  end

  def shoot_free_throw
    self.all_time_stat.increment!(:free_throw_attempted)
    self.game_stat.try(:increment!, :free_throw_attempted)
    if in_a_team?
      self.team.all_time_stat.increment!(:free_throw_attempted)
      self.team.game_stat.try(:increment!, :free_throw_attempted)
    end
  end

  def make_free_throw
    self.all_time_stat.increment!(:free_throw_made)
    self.game_stat.try(:increment!, :free_throw_made)
    if in_a_team?
      self.team.all_time_stat.increment!(:free_throw_made)
      self.team.game_stat.try(:increment!, :free_throw_made)
    end
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
