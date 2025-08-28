# frozen_string_literal: true

class CreateUserCallsigns < ActiveRecord::Migration[8.0]
  def change
    create_table :user_callsigns do |t|
      ## Custom fields
      t.string :callsign, limit: 50, null: false, index: true, unique: true

      ## References
      t.references :institution, null: false, foreign_key: { to_table: :institutions }, index: true, unique: true
      t.references :user, null: false, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
