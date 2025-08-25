class CreateContactPhoneNumbers < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_phone_numbers, primary_key: [ :contact_id, :phone_number_id ] do |t|
      t.boolean :is_primary, null: false, default: false

      ## References
      t.references :contact, null: false, foreign_key: { to_table: :contacts }
      t.references :phone_number, null: false, foreign_key: { to_table: :phone_numbers }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
