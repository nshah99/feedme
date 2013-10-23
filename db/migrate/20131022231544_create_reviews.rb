class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :order_id
      t.text :review_text

      t.timestamps
    end
  end
end
