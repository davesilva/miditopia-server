# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@test.com" }
  sequence(:username) { |n| "test_user#{n}" }

  factory :user do
    email
    username
    password 'password123'
    password_confirmation 'password123'
  end
end
