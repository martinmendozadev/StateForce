class CreateScheduleEntries < ActiveRecord::Migration[8.0]
  def change
    ## Enums
    create_enum :recurrence_rule, %w[once daily weekly monthly yearly]

    create_table :schedule_entries do |t|
      t.string :title, limit: 100
      t.text :description
      t.interval :duration
      t.datetime :ends_at
      t.datetime :estimated_ends_at
      t.enum :priority_level, enum_type: "priority_level", null: false, default: "unknown"
      t.enum :recurrence_rule, enum_type: "recurrence_rule", null: false, default: "once"
      t.datetime :repeat_until
      t.datetime :scheduled_at
      t.enum :status, enum_type: "event_status", null: false, default: "pending"
      t.enum :visibility, enum_type: "visibility", default: "private", null: false

      ## References
      t.references :creator_user, null: false, foreign_key: { to_table: :users }
      t.references :event, null: false, foreign_key: true

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
