class AddStartAndEndToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :start, :timestamp
    add_column :appointments, :end, :timestamp
  end
end
