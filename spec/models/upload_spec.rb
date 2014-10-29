require 'rails_helper'

RSpec.describe Upload, type: :model do
  it { should belong_to :user }
  it { should belong_to :track }

  it { should validate_presence_of :midi_file }

  it 'requires that midi_file is a file' do
    upload = Upload.new(midi_file: 'Not a midi file')
    expect(upload).to_not be_valid
  end
end
