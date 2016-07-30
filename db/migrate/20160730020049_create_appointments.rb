class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.timestamp :date_time
      t.date :date
      t.time :time
      t.references :user, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
