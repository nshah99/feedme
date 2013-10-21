class AddIndexToListingsUserId < ActiveRecord::Migration
  def change
    add_index :listings, [:user_id, :created_at]
  end
end
