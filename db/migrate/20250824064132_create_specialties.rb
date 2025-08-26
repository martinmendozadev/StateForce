# frozen_string_literal: true

class CreateSpecialties < ActiveRecord::Migration[8.0]
  def change
    create_table :specialties do |t|
      ## Custom fields
      t.string :code, limit: 50
      t.text   :description
      t.string :name, null: false, limit: 150

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    ## Indexes
    add_index :specialties, :name, unique: true
    add_index :specialties, :code, unique: true
  end
end
