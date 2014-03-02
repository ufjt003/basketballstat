module ValidatedStat
  extend ActiveSupport::Concern

  included do
    validates :two_pointer_attempt, presence: true
    validates :two_pointer_make, presence: true
    validates :three_pointer_attempt, presence: true
    validates :three_pointer_make, presence: true
    validates :free_throw_attempt, presence: true
    validates :free_throw_make, presence: true
    validates :assist, presence: true
    validates :rebound, presence: true
    validates :steal, presence: true
    validates :block, presence: true
    validates :turnover, presence: true
  end

  module ClassMethods
  end
end
