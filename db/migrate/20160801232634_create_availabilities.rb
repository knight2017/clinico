class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.references :doctor, index: true, foreign_key: true
      t.timestamp :start
      t.timestamp :end

      t.timestamps null: false
    end
  end
end
