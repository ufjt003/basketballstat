class Player < ActiveRecord::Base
  include PlayMakable

  validates :name, presence: true

  after_create :create_stat

  has_one :stat, :foreign_key => 'player_id', :class_name => "PlayerStat"
  belongs_to :team

  private

  def create_stat
    PlayerStat.create(player_id: self.id)
  end
end
