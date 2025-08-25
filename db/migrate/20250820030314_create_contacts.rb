class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.string :email, limit: 150
      t.string :name, limit: 50
      t.string :radio_frequency, limit: 75
      t.integer :channel, limit: 2

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
    add_index :contacts, :email, unique: true
  end
end
