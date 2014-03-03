module StatMethods
  extend ActiveSupport::Concern

  included do
    def points
      2 * two_pointer_make + 3 * three_pointer_make + free_throw_make
    end

    def field_goal_attempt
      two_pointer_attempt + three_pointer_attempt
    end

    def field_goal_make
      two_pointer_make + three_pointer_make
    end

    def field_goal_percentage
      field_goal_make.to_f / field_goal_attempt
    end

    def free_throw_percentage
      free_throw_make.to_f / free_throw_attempt
    end

    def three_pointer_percentage
      three_pointer_make.to_f / three_pointer_attempt
    end
  end
end
