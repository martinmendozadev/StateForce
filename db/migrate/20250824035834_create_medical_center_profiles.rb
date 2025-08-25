class CreateMedicalCenterProfiles < ActiveRecord::Migration[8.0]
  def change
    # Enums
    create_enum :proficiency_level, %w[advanced basic medium unknown]

    create_table :medical_center_profiles do |t|
      t.boolean :external_pharmacy_available, default: false
      t.boolean :internal_pharmacy_available, default: false
      t.enum :level, enum_type: :proficiency_level, default: "unknown", null: false
      t.integer :operating_rooms_total, limit: 2, default: 0, null: false
      t.integer :operating_rooms_available, limit: 2, default: 0, null: false

      ## References
      t.references :operational_unit, null: false, foreign_key: { to_table: :operational_units }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
