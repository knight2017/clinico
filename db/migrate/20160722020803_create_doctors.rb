class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.text   :information
      t.string :location
      t.string :average_rating

      t.timestamps null: false
    end
    add_index :doctors, [:first_name, :last_name], unique: true

  end
end
