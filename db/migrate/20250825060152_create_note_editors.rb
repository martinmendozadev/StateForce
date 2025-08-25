class CreateNoteEditors < ActiveRecord::Migration[8.0]
  def change
    create_table :note_editors, primary_key: [ :note_id, :user_id ] do |t|
      t.timestamp :last_edited_at

      ## References
      t.references :note, null: false, foreign_key: { to_table: :notes }
      t.references :user, null: false, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
