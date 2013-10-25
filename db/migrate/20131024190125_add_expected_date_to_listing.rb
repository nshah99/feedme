class AddExpectedDateToListing < ActiveRecord::Migration
  def change
    add_column :listings, :expected_date, :datetime
  end
end
