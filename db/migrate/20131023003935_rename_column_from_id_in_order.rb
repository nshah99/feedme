class RenameColumnFromIdInOrder < ActiveRecord::Migration
  def change
    rename_column :orders, :from_id, :user_id
  end
end
