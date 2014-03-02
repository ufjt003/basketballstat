FactoryGirl.define do
  factory :team_stat do
    team { FactoryGirl.create(:team) }
  end
end
