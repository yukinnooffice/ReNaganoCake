class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :order_price
      t.integer :quantity
      t.integer :make_status, default: 0

      t.timestamps
    end
  end
end
