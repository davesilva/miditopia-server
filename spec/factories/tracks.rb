# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:artist) { |n| "Artist#{n}" }
  sequence(:title) { |n| "Song#{n}" }

  factory :track do
    artist
    title
  end
end
