class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :addressee
      t.string :zipcode
      t.string :send_to_address
      t.integer :freight, default: 800
      t.integer :total_price
      t.integer :how_to_pay, default: 0
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end

