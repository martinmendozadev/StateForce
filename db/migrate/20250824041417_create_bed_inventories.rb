class CreateBedInventories < ActiveRecord::Migration[8.0]
  def change
    # Enums
    create_enum :bed_type, %w[
      emergency
      gynecology
      icu
      internal_medicine
      isolated
      neonatal_icu
      pediatric
      trauma
      general
      maternity
    ]

    create_table :bed_inventories do |t|
      t.integer :available, limit: 2, default: 0, null: false
      t.enum :bed_type, enum_type: :bed_type, null: false
      t.integer :total, limit: 2, default: 0, null: false

      ## References
      t.references :operational_unit, null: false, foreign_key: { to_table: :operational_units }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
