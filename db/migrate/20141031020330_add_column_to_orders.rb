class AddColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :price, :float
    add_column :orders, :description, :string
    

  end
end
