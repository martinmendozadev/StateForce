class CreateOperationalUnitsAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :operational_units_attachments, primary_key: [ :operational_unit_id, :attachment_id ] do |t|
      ## References
      t.references :operational_unit, null: false, foreign_key: { to_table: :operational_units }
      t.references :attachment, null: false, foreign_key: { to_table: :attachments }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
