class Upload < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validates :midi_file, presence: true
end
