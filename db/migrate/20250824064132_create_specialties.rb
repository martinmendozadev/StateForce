# frozen_string_literal: true

class CreateSpecialties < ActiveRecord::Migration[8.0]
  def change
    create_table :specialties do |t|
      ## Custom fields
      t.string :code, limit: 50, unique: true, index: true
      t.text   :description
      t.string :name, null: false, limit: 150, unique: true, index: true

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
