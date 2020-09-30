class ChangeColumnToCustomers < ActiveRecord::Migration[5.2]
  def up
  	change_column :customers, :customer_status, :boolean, default: true
  end

  def down
  	change_column :customers, :customer_status, :boolean, default: false
  end
end
