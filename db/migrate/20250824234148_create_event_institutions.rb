class CreateEventInstitutions < ActiveRecord::Migration[8.0]
  def change
    create_table :event_institutions do |t|
      t.datetime :assigned_at, null: false, default: -> { "CURRENT_TIMESTAMP" }

      ## References
      t.references :event,       null: false, foreign_key: { to_table: :events }
      t.references :institution, null: false, foreign_key: { to_table: :institutions }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
