require 'rails_helper'

RSpec.describe Upload, type: :model do
  it { should belong_to :user }
  it { should belong_to :track }

  it { should validate_presence_of :midi_file }
end
