FactoryGirl.define do
  factory :player_stat do
    player { FactoryGirl.create(:player) }
  end
end
