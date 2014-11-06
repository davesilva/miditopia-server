# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :upload do
    midi_file { fixture_file_upload('spec/fixtures/files/test.mid', 'audio/midi') }
    track
    user
  end
end
