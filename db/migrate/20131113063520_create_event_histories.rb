class CreateEventHistories < ActiveRecord::Migration
  def change
    create_table :event_histories do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
