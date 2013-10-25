class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :address
      t.datetime :event_date
      t.datetime :event_time

      t.timestamps
    end
  end
end
