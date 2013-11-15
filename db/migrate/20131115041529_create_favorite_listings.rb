class CreateFavoriteListings < ActiveRecord::Migration
  def change
    create_table :favorite_listings do |t|
      t.integer :user_id
      t.integer :listing_id

      t.timestamps
    end
  end
end
