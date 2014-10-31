class CreateServersTable < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :password
      t.string :color
      t.timestamps
    end
  end
end
