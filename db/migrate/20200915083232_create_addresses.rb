class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :customer_id
      t.string :ship_name
      t.string :zipcode
      t.string :address

      t.timestamps
    end
  end
end
