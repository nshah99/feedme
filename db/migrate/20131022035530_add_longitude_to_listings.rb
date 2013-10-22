class AddLongitudeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :longitude, :float
  end
end
