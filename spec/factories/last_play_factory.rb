# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :last_play do
    player_id 1
    game_id 1
    action "MyString"
  end
end
