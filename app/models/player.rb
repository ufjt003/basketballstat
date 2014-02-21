class Player < ActiveRecord::Base
  validates :name, presence: true

  after_create :create_player_stat

  has_one :player_stat
  belongs_to :team

  def shoot
    self.player_stat.increment!(:field_goal_attempted)
  end

  def make_field_goal
    self.player_stat.increment!(:field_goal_made)
  end

  def shoot_three_pointer
    self.player_stat.increment!(:three_pointer_attempted)
  end

  def make_three_pointer
    self.player_stat.increment!(:three_pointer_made)
  end

  def shoot_free_throw
    self.player_stat.increment!(:free_throw_attempted)
  end

  def make_free_throw
    self.player_stat.increment!(:free_throw_made)
  end

  def assist
    self.player_stat.increment!(:assist)
  end

  def block
    self.player_stat.increment!(:block)
  end

  def steal
    self.player_stat.increment!(:steal)
  end

  def rebound
    self.player_stat.increment!(:rebound)
  end

  def turnover
    self.player_stat.increment!(:turnover)
  end

  private

  def create_player_stat
    PlayerStat.create(player_id: self.id)
  end
end
