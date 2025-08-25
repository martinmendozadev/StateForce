class CreateInstitutions < ActiveRecord::Migration[8.0]
  def change
    create_enum :sector_type, %w[public private social unknown]
    create_enum :resource_status, %w[available maintenance out_of_service unknown]

    create_table :institutions do |t|
      t.string :callsign, limit: 50
      t.text :description
      t.string :name, null: false, limit: 150
      t.enum :sector_type, enum_type: "sector_type", default: "unknown", null: false
      t.enum :status, enum_type: "resource_status", default: "unknown", null: false

      ## References
      t.references :director, foreign_key: { to_table: :users }, index: true
      t.references :location, null: false, foreign_key: true
      t.references :parent_institution, foreign_key: { to_table: :institutions }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :institutions, :name, unique: true
    add_index :institutions, :callsign, unique: true
  end
end
