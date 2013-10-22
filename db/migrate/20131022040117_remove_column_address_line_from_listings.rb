class RemoveColumnAddressLineFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :address_line
  end
end
