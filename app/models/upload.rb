class Upload < ActiveRecord::Base
  mount_uploader :midi_file, MidiUploader

  belongs_to :track
  belongs_to :user

  validates :midi_file, presence: true
end
