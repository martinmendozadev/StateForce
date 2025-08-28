# frozen_string_literal: true

class CreateResourceCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :resource_categories do |t|
      ## Custom fields
      t.text   :description
      t.string :name, limit: 150, null: false

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    ## Indexes
    add_index :resource_categories, [ :name ], unique: true
  end
end
