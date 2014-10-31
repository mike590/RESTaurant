class CreatePartiesTable < ActiveRecord::Migration
  def change
  	create_table :parties do |t|
  		t.string :name
  		t.integer :size
  		t.string :paid
  		t.timestamps
  	end
  end
end
