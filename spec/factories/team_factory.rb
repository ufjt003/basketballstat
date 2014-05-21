# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name { Forgery(:name).full_name }
  end

  factory :complete_team, class: Team do
    name { Forgery(:name).full_name }
    after(:create) do |team|
      5.times { team.add_player(FactoryGirl.create(:player)) }
    end
  end
end
