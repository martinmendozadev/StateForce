class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      t.string :name, limit: 150, null: false
      t.text :description
      t.integer :available_units, null: false, default: 0
      t.integer :total_units, null: false, default: 0
      t.string :units_identifier, limit: 50

      ## References
      t.references :icon, foreign_key: { to_table: :attachments }
      t.references :institution, null: false, foreign_key: { to_table: :institutions }
      t.references :location, null: false, foreign_key: { to_table: :locations }
      t.references :resource_type, null: false, foreign_key: { to_table: :resource_types }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :resources, [ :name, :institution_id ], unique: true
  end
end
