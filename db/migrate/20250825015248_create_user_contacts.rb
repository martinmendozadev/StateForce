class CreateUserContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :user_contacts, primary_key: [ :user_id, :contact_id, :contact_type ] do |t|
      t.enum :contact_type, enum_type: "contact_type", null: false, default: "primary"

      ## References
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :contact, null: false, foreign_key: { to_table: :contacts }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
