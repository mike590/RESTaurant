class AddColumnToParties < ActiveRecord::Migration
  def change
    add_column :parties, :shape_selector, :integer
    add_column :parties, :comments, :string
    add_column :parties, :server_id, :integer
  end
end
