class CreatePhoneNumbers < ActiveRecord::Migration[8.0]
  def change
    ## Enums
    create_enum :phone_type, %w[home landline mobile office other personal unknown]

    create_table :phone_numbers do |t|
      t.string :extension, limit: 3
      t.string :number, limit: 25
      t.enum :phone_type, enum_type: "phone_type", null: false, default: "personal"

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
