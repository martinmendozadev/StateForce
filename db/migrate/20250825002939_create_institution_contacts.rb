# frozen_string_literal: true

class CreateInstitutionContacts < ActiveRecord::Migration[8.0]
  def change
    ## Enums
    create_enum :contact_type, %w[emergency primary technical_support]

    create_table :institution_contacts do |t|
      ## Custom fields
      t.enum :contact_type, enum_type: "contact_type", null: false, default: "primary"

      ## References
      t.references :contact, null: false, foreign_key: { to_table: :contacts }
      t.references :institution, null: false, foreign_key: { to_table: :institutions }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
