module PlayMakable
  extend ActiveSupport::Concern

  included do
    def shoot
      self.stat.increment!(:field_goal_attempted)
    end

    def make_field_goal
      self.stat.increment!(:field_goal_made)
    end

    def shoot_three_pointer
      self.stat.increment!(:three_pointer_attempted)
    end

    def make_three_pointer
      self.stat.increment!(:three_pointer_made)
    end

    def shoot_free_throw
      self.stat.increment!(:free_throw_attempted)
    end

    def make_free_throw
      self.stat.increment!(:free_throw_made)
    end

    def assist
      self.stat.increment!(:assist)
    end

    def block
      self.stat.increment!(:block)
    end

    def steal
      self.stat.increment!(:steal)
    end

    def rebound
      self.stat.increment!(:rebound)
    end

    def turnover
      self.stat.increment!(:turnover)
    end
  end
end
