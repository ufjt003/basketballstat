# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_stat do
    field_goal_attempted 1
    field_goal_made 1
    three_pointer_attempted 1
    three_pointer_made 1
    free_throw_attempted 1
    free_throw_made 1
    assist 1
    rebound 1
    steal 1
    block 1
    turnover 1
    team_id 1
  end
end
