FactoryGirl.define do
  factory :player_stat do
    field_goal_attempted 1
    field_goal_made 1
    three_pointer_attempted 1
    three_pointer_made 1
    player { FactoryGirl.create(:player) }
  end
end
