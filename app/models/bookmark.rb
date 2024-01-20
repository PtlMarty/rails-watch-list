class Bookmark < ApplicationRecord
  validates :comment, length: { minimum: 6 }
  validates :movie_id, uniqueness: { scope: :list_id }
  belongs_to :list
  has_and_belongs_to_many :movies
end
