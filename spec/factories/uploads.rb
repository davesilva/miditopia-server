# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload do
    midi_file File.open(File.join(Rails.root, 'spec/fixtures/files/test.mid'))
    track
    user
  end
end
