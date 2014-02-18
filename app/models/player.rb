class Player < ActiveRecord::Base
  validates :name, presence: true

  after_create :create_player_stat

  has_one :player_stat

  private

  def create_player_stat
    PlayerStat.create(player_id: self.id)
  end
end
