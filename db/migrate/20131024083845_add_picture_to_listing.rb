class AddPictureToListing < ActiveRecord::Migration
  def change
    add_column :listings, :picture, :string
  end
end
