# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      ## Custom fields
      t.integer :channel, limit: 2
      t.string :email
      t.string :name
      t.string :radio_frequency, limit: 75

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    ## Indexes
    add_index :contacts, [ :email ], unique: true
  end
end
