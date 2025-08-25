class CreateEventNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :event_notes, primary_key: [ :event_id, :note_id ] do |t|
      ## References
      t.references :event, null: false, foreign_key: { to_table: :events }
      t.references :note, null: false, foreign_key: { to_table: :notes }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
