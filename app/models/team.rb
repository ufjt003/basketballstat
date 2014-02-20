class Team < ActiveRecord::Base
  validates :name, presence: true

  has_many :players
  has_one :team_stat

  after_create :create_team_stat

  private

  def create_team_stat
    TeamStat.create(team_id: self.id)
  end

end
