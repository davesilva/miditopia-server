# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    username "MyString"
    login_name "MyString"
    password_digest "MyString"
  end
end
