class CreateResourceAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :resource_attachments, primary_key: [ :resource_id, :attachment_id ] do |t|
      ## References
      t.references :resource, null: false, foreign_key: { to_table: :resources }
      t.references :attachment, null: false, foreign_key: { to_table: :attachments }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
