class CreateEventAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :event_attachments, primary_key: [ :event_id, :attachment_id ] do |t|
      ## References
      t.references :event, null: false, foreign_key: { to_table: :events }
      t.references :attachment, null: false, foreign_key: { to_table: :attachments }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
