class Track < ActiveRecord::Base
  has_many :uploads

  validates :artist, presence: true
  validates :title, presence: true,
                    uniqueness: { scope: :artist }
end
