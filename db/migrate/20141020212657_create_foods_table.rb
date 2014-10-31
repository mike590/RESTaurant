class CreateFoodsTable < ActiveRecord::Migration
  def change
  	create_table :foods do |t|
  		t.float :price
  		t.string :name
  		t.timestamps
  	end
  end
end
