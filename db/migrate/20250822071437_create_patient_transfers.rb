class CreatePatientTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :patient_transfers do |t|
      t.timestamp :arrival_time
      t.timestamp :departure_time
      t.enum :status, enum_type: "event_status", null: false, default: "pending"

      ## References
      t.references :accepted_by_user, null: false, foreign_key: { to_table: :users }
      t.references :destination_institution, null: false, foreign_key: { to_table: :institutions }
      t.references :event, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.references :requesting_user, null: false, foreign_key: { to_table: :users }
      t.references :transport_resource, null: false, foreign_key: { to_table: :resources }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
