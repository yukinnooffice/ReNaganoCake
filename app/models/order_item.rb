class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  enum make_status: { 着手不可:0, 製作待ち:1, 製作中:2, 製作完了:3 }

  validates :order_price, presence: true
  validates :quantity, presence: true, length: {maximum: 100}

   def subtotal
    order_price * quantity
  end
end
