class CreateUserCallsigns < ActiveRecord::Migration[8.0]
  def change
    create_table :user_callsigns do |t|
      t.string :callsign, limit: 50, null: false

      ## References
      t.references :institution, null: false, foreign_key: { to_table: :institutions }
      t.references :user, null: false, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :user_callsigns, [ :callsign, :institution_id ], unique: true, name: "idx_unique_callsign_per_institution"
  end
end
