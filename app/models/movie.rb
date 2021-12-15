class Movie < ApplicationRecord
  validates :title, presence: true
  has_one :external_rating
end
