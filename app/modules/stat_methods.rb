module StatMethods
  extend ActiveSupport::Concern

  included do
    def points
      2 * field_goal_made + 3 * three_pointer_made + free_throw_made
    end
  end
end
