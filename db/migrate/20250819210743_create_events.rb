class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    ## Enums
    create_enum :event_category, %w[
      animal_rescue bomb_threat emergency epidemic_response evacuation fire_incident
      flood_response hazardous_material infrastructure_collapse medical_emergency
      missing_person natural_disaster operative other power_outage public_disturbance
      rescue_operation simulacrum support_request traffic_accident training unknown
    ]
    create_enum :priority_level, %w[critical high low medium unknown]
    create_enum :event_status, %w[assigned arrived cancelled closed en_route on_scene pending resolved]

    create_table :events do |t|
      t.text :description
      t.timestamp :ended_at
      t.enum :event_type, enum_type: "event_category", null: false, default: "emergency"
      t.string :event_code, limit: 50
      t.enum :priority_level, enum_type: "priority_level", null: false, default: "unknown"
      t.integer :people_affected, limit: 2, default: 0
      t.string :reported_by_text, limit: 150
      t.timestamp :reported_time, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.enum :status, enum_type: "event_status", null: false, default: "pending"

      ## References
      t.references :location, foreign_key: true

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :events, :event_code, unique: true
  end
end
