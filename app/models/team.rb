class Team < ActiveRecord::Base
  include PlayMakable

  validates :name, presence: true

  has_many :players
  has_one :stat, :foreign_key => 'team_id', :class_name => "TeamStat"

  after_create :create_stat

  private

  def create_stat
    TeamStat.create(team_id: self.id)
  end

end
