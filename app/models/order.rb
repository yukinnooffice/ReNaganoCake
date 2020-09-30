class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  belongs_to :product, optional: true


  validates :select_address, acceptance: true

  with_options presence: true do
    validates :addressee, length: {maximum: 20, minimum: 2}
    validates :zipcode, format: {with: /\A\d{7}\z/}, numericality: true
    validates :send_to_address
    validates :freight
    validates :total_price
    validates :how_to_pay
    validates :order_status
  end


  enum how_to_pay: { 銀行振込:0, クレジットカード:1 }
  enum order_status: { 入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4 }

  scope :quantity_total, -> {
    joins(:order_items)
      .select("
        orders.id,
        orders.created_at,
        orders.addressee,
        SUM(order_items.quantity) as total_quantity,
        orders.order_status"
      ).group(:id)
  }
end
