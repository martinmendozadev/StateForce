class CreateSpecialties < ActiveRecord::Migration[8.0]
  def change
    create_table :specialties do |t|
      t.string :name, null: false, limit: 150
      t.text :description
      t.string :code, limit: 50

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :specialties, :name, unique: true
    add_index :specialties, :code, unique: true
  end
end
