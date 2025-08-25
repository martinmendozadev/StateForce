class CreatePatientTransfersNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :patient_transfers_notes, primary_key: [ :patient_transfer_id, :note_id ] do |t|
      ## References
      t.references :patient_transfer, null: false, foreign_key: { to_table: :patient_transfers }
      t.references :note, null: false, foreign_key: { to_table: :notes }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
