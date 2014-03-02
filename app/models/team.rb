class Team < ActiveRecord::Base

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

  def game_stat
    TeamStat.find_by(game_id: self.game, team_id: self.id) if self.game
  end

  private

  def create_all_time_stat
    AllTimeTeamStat.create(team_id: self.id)
  end

end
