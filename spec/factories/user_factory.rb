FactoryGirl.define do
  factory :user do
    sequence(:number)
    sequence(:email) { |n| "user_#{n}@test.com" }
    name { Forgery(:name).full_name }
    password "12345678"
    password_confirmation "12345678"
  end
end
