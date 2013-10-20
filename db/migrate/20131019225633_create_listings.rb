class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :email
      t.string :name
      t.string :item
      t.float :price
      t.text :address_line
      t.string :city
      t.string :state
      t.string :zip
      t.integer :quantity
      t.string :cuisine
      t.datetime :expected_time
      t.text :special_requests

      t.timestamps
    end
  end
end
