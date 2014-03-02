module StatMethods
  extend ActiveSupport::Concern

  included do
    def points
      2 * two_pointer_make + 3 * three_pointer_make + free_throw_make
    end
  end
end
