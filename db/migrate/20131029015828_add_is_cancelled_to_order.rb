class AddIsCancelledToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :is_cancelled, :integer
  end
end
