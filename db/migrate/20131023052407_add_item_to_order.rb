class AddItemToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :item, :string
  end
end
