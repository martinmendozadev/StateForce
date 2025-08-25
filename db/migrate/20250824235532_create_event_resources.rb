class CreateEventResources < ActiveRecord::Migration[8.0]
  def change
    create_table :event_resources do |t|
      t.integer :quantity_assigned, null: false, default: 1
      t.datetime :assigned_at, null: false, default: -> { "CURRENT_TIMESTAMP" }

      ## References
      t.references :event,       null: false, foreign_key: { to_table: :events }
      t.references :resource,    null: false, foreign_key: { to_table: :resources }
      t.references :assigned_by_user, null: false, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
