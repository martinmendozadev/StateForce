class CreateResourceNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :resource_notes, primary_key: [ :resource_id, :note_id ] do |t|
      ## References
      t.references :resource, null: false, foreign_key: { to_table: :resources }
      t.references :note, null: false, foreign_key: { to_table: :notes }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
