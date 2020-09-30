class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, presence: true, numericality: true
end
