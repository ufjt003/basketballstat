module ValidatedStat
  extend ActiveSupport::Concern

  included do
    validates :field_goal_attempted, presence: true
    validates :field_goal_made, presence: true
    validates :three_pointer_attempted, presence: true
    validates :three_pointer_made, presence: true
    validates :free_throw_attempted, presence: true
    validates :free_throw_made, presence: true
    validates :assist, presence: true
    validates :rebound, presence: true
    validates :steal, presence: true
    validates :block, presence: true
    validates :turnover, presence: true
  end

  module ClassMethods
  end
end
