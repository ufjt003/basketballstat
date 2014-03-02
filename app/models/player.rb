class Player < ActiveRecord::Base
  include PlayMakable

  validates :name, presence: true

  after_create :create_all_time_stat

  has_one :all_time_stat, :foreign_key => 'player_id', :class_name => "AllTimePlayerStat"
  belongs_to :team

  private

  def create_all_time_stat
    AllTimePlayerStat.create(player_id: self.id)
  end
end
