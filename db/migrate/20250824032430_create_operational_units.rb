class CreateOperationalUnits < ActiveRecord::Migration[8.0]
  def change
    create_enum :facility_type, %w[hospital clinic rescue_base command_center other]

    create_table :operational_units do |t|
      t.text :coverage
      t.string :name, limit: 150, null: false
      t.enum :facility_type, enum_type: :facility_type, null: false
      t.enum :triage_status, enum_type: :triage_status, null: false, default: "unknown"

      ## References
      t.references :on_charge_shift_user, foreign_key: { to_table: :users }
      t.references :parent_institution, null: false, foreign_key: { to_table: :institutions }
      t.references :location, null: false, foreign_key: { to_table: :locations }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
