class TeamGame < ActiveRecord::Base
  validates :team_id, presence: true
  validates :game_id, presence: true
  validates_uniqueness_of :game_id, scope: :team_id
end
