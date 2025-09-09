# frozen_string_literal: true

class CreateCompetencies < ActiveRecord::Migration[8.0]
  def change
    create_table :competencies do |t|
      ## Custom fields
      t.enum :level, enum_type: :proficiency_level, default: "unknown", null: false

      ## References
      t.references :specialty, null: false, foreign_key: { to_table: :specialties }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
