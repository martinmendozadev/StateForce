class CreateEventInstitutions < ActiveRecord::Migration[8.0]
  def change
    create_table :event_institutions do |t|
      t.datetime :assigned_at, null: false, default: -> { "CURRENT_TIMESTAMP" }

      ## References
      t.references :event,       null: false, foreign_key: true, type: :bigint
      t.references :institution, null: false, foreign_key: true, type: :bigint

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
