class List < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3}, uniqueness: true
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
end
