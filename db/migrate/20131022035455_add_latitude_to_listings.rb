class AddLatitudeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :latitude, :float
  end
end
