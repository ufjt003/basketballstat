# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :all_time_player_stat do
    player { FactoryGirl.create(:player) }
  end
end
