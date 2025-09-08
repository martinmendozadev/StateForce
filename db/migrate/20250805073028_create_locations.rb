# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    ## Extension
    enable_extension 'postgis'

    create_table :locations do |t|
      ## Custom fields
      t.string :address
      t.st_point :coordinates, geographic: true, srid: 4326
      t.text    :key_name
      t.string  :place_name, limit: 100

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
