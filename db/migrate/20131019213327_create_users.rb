class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.string :name
      t.text :description
      t.text :cuisines
      t.text :address_line
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
