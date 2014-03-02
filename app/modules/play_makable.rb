module PlayMakable
  extend ActiveSupport::Concern

  included do
    def shoot
      self.all_time_stat.increment!(:field_goal_attempted)
    end

    def make_field_goal
      self.all_time_stat.increment!(:field_goal_made)
    end

    def shoot_three_pointer
      self.all_time_stat.increment!(:three_pointer_attempted)
    end

    def make_three_pointer
      self.all_time_stat.increment!(:three_pointer_made)
    end

    def shoot_free_throw
      self.all_time_stat.increment!(:free_throw_attempted)
    end

    def make_free_throw
      self.all_time_stat.increment!(:free_throw_made)
    end

    def assist
      self.all_time_stat.increment!(:assist)
    end

    def block
      self.all_time_stat.increment!(:block)
    end

    def steal
      self.all_time_stat.increment!(:steal)
    end

    def rebound
      self.all_time_stat.increment!(:rebound)
    end

    def turnover
      self.all_time_stat.increment!(:turnover)
    end
  end
end
