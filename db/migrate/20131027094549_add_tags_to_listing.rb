class AddTagsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :tags, :string
  end
end
