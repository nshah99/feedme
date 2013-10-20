class AddIndexToListingEmail < ActiveRecord::Migration
  def change
    add_index :listings, :email, unique: true
  end
end
