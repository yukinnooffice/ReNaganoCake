class Product < ApplicationRecord
  belongs_to :genre
  has_many :order_items, dependent: :destroy
  has_many :orders
  has_many :cart_items
  attachment :image

  with_options presence: true do
    validates :genre_id
    validates :name, length: {maximum: 20, minimum: 1}
    validates :introduction
    validates :price, numericality: true
  end

  validates :status, inclusion: { in: [true, false] }

    TAX = 1.1

    def tax_price
      tax_price = price * TAX
      tax_price.floor
    end

  def self.search(search, model)
    if model == "product"
      Product.where(['name LIKE ?', "%#{search}%"])
    else
      Product.all
    end
  end
end
