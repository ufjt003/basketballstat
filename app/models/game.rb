class Game < ActiveRecord::Base
  validates :gametime, presence: true

  has_many :teams
end
