class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    ## Enums
    create_enum :gender, %w[female intersex male other]
    create_enum :triage_status, %w[black green red unknown yellow]

    create_table :patients do |t|
      t.string  :name, null: false, limit: 100
      t.integer :age, limit: 2, null: false
      t.enum    :gender, enum_type: :gender, null: false, default: "other"
      t.enum    :triage_status, enum_type: :triage_status, null: false, default: "unknown"

      ## References
      t.references :event, null: false, foreign_key: true

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
