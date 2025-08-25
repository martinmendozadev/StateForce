class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    enable_extension 'postgis'

    create_table :locations do |t|
      t.string :address, limit: 150
      t.text :key_name
      t.string :place_name, limit: 100
      t.st_point :coordinates, geographic: true, srid: 4326

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
