class Movie < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3}, uniqueness: true
  validates :overview, presence: true, length: { minimum: 3}
  has_many :bookmarks
end
