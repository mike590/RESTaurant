class CreateOrdersTable < ActiveRecord::Migration
  def change
  	create_table :orders do |t|
  		t.integer :food_id
  		t.integer :party_id
  		t.string :no_charge
  		t.timestamps
  	end
  end
end
