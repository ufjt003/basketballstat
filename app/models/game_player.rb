class GamePlayer < ActiveRecord::Base
  validates :game_id, presence: true
  validates :player_id, presence: true
  validates_uniqueness_of :player_id, scope: :game_id
end
