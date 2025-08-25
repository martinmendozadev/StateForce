class CreateScheduleEntriesInstitutions < ActiveRecord::Migration[8.0]
  def change
    create_table :schedule_entries_institutions, primary_key: [ :schedule_entry_id, :institution_id ] do |t|
      ## References
      t.references :schedule_entry, null: false, foreign_key: { to_table: :schedule_entries }
      t.references :institution, null: false, foreign_key: { to_table: :institutions }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
