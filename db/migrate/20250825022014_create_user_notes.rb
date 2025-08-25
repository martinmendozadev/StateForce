class CreateUserNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :user_notes, primary_key: [ :user_id, :note_id ] do |t|
      t.boolean :starred, null: false, default: false

      ## References
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :note, null: false, foreign_key: { to_table: :notes }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
