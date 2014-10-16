class Track < ActiveRecord::Base
  has_many :uploads

  validates :title, presence: true,
                    uniqueness: true
  validates :artist, presence: true,
                     uniqueness: true
end
