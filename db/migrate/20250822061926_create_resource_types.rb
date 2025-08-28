# frozen_string_literal: true

class CreateResourceTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :resource_types do |t|
      ## Custom fields
      t.text   :description
      t.string :name, limit: 150, null: false, unique: true, index: true

      ## References
      t.references :resource_category, null: false, foreign_key: { to_table: :resource_categories }, unique: true, index: true

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
