FactoryGirl.define do
  factory :player do
    name { Forgery(:name).full_name }
    sequence(:number)
  end
end
