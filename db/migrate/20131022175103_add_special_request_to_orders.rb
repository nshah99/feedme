class AddSpecialRequestToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :special_request, :string
  end
end
