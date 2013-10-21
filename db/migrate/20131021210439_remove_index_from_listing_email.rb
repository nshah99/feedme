class RemoveIndexFromListingEmail < ActiveRecord::Migration
  def change
    remove_index :listings, :email
  end
end
