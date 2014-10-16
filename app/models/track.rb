class Track < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true,
                    uniqueness: true
  validates :artist, presence: true,
                     uniqueness: true
end
