class CreatePatientsNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :patients_notes, primary_key: [ :patient_id, :note_id ] do |t|
      ## References
      t.references :patient, null: false, foreign_key: { to_table: :patients }
      t.references :note, null: false, foreign_key: { to_table: :notes }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
