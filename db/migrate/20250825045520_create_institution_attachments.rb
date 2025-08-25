class CreateInstitutionAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :institution_attachments, primary_key: [ :institution_id, :attachment_id ] do |t|
      ## References
      t.references :institution, null: false, foreign_key: { to_table: :institutions }
      t.references :attachment, null: false, foreign_key: { to_table: :attachments }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
