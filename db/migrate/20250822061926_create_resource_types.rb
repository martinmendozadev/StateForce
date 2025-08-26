class CreateResourceTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :resource_types do |t|
      t.text   :description
      t.string :name, limit: 150, null: false

      ## References
      t.references :resource_category, null: false, foreign_key: { to_table: :resource_categories }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :resource_types, [ :name, :resource_category_id ], unique: true
  end
end
