class CreateInstitutionNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :institution_notes, primary_key: [ :institution_id, :note_id ] do |t|
      ## References
      t.references :institution, null: false, foreign_key: { to_table: :institutions }
      t.references :note, null: false, foreign_key: { to_table: :notes }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
