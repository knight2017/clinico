class AddGeocodingFieldsToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :address, :string
    add_column :doctors, :longitude, :float
    add_column :doctors, :latitude, :float
  end
end
