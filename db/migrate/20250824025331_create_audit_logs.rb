class CreateAuditLogs < ActiveRecord::Migration[8.0]
  def change
    create_enum :actions, %w[created deleted read restored updated]
    create_enum :entity_names, %w[contacts events resources user patients institutions attachments schedule_entries phone_numbers invites resource_categories resource_types patient_transfers audit_logs unknown]

    create_table :audit_logs do |t|
      t.enum :entity_name, enum_type: "entity_names", null: false, default: "unknown"
      t.enum :action, enum_type: "actions", null: false
      t.integer :entity_id, null: false
      t.jsonb :new_value, null: false
      t.jsonb :old_value

      ## References
      t.references :user, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamp :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
