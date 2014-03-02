FactoryGirl.define do
  factory :all_time_team_stat do
    team { FactoryGirl.create(:team) }
  end
end
