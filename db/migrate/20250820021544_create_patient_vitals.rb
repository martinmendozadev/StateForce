class CreatePatientVitals < ActiveRecord::Migration[8.0]
  def change
    create_table :patient_vitals do |t|
      t.integer :blood_pressure_systolic, limit: 2
      t.integer :blood_pressure_diastolic, limit: 2
      t.integer :capillary_blood_glucose, limit: 2
      t.jsonb :glasgow_coma_score
      t.integer :heart_rate, limit: 2
      t.integer :oxygen_saturation, limit: 2
      t.datetime :recorded_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.integer :respiratory_rate, limit: 2
      t.decimal :temperature, precision: 4, scale: 1, null: true

      ## References
      t.references :patient, null: false, foreign_key: true
      t.references :recorded_by_user, null: false, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
