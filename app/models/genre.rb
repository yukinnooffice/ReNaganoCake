class Genre < ApplicationRecord
  has_many :products

  validates :genre_name, presence: true, length: {maximum: 15}
end
