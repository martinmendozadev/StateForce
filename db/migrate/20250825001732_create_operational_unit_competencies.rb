class CreateOperationalUnitCompetencies < ActiveRecord::Migration[8.0]
  def change
    create_table :operational_unit_competencies, primary_key: [ :operational_unit_id, :competency_id ] do |t|
      ## References
      t.references :operational_unit, null: false, foreign_key: { to_table: :operational_units }
      t.references :competency, null: false, foreign_key: { to_table: :competencies }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
