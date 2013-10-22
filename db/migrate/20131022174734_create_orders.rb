class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :listing_id
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
