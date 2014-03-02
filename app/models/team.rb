class Team < ActiveRecord::Base
  include PlayMakable

  validates :name, presence: true

  has_many :players
  has_one :all_time_stat, :foreign_key => 'team_id', :class_name => "AllTimeTeamStat"
  belongs_to :game

  after_create :create_all_time_stat

  def add_player(player)
    self.players << player
  end

  def remove_player(player)
    self.players.delete(player)
  end

  private

  def create_all_time_stat
    AllTimeTeamStat.create(team_id: self.id)
  end

end
