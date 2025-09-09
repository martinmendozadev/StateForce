# frozen_string_literal: true

class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      ## Custom fields
      t.integer :available_units, limit: 2, null: false, default: 0
      t.text    :description
      t.string  :name, null: false
      t.integer :total_units, limit: 2, null: false, default: 0
      t.string  :units_identifier

      ## References
      t.references :icon, foreign_key: { to_table: :attachments }
      t.references :institution, null: false, foreign_key: { to_table: :institutions }
      t.references :location, null: false, foreign_key: { to_table: :locations }
      t.references :resource_type, null: false, foreign_key: { to_table: :resource_types }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    ## Indexes
    add_index :resources, [ :name,  :institution_id ], unique: true
  end
end
