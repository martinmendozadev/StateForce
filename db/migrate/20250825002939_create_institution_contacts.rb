class CreateInstitutionContacts < ActiveRecord::Migration[8.0]
  def change
    create_enum :contact_type, %w[emergency primary technical_support]

    create_table :institution_contacts do |t|
      t.enum :contact_type, enum_type: "contact_type", null: false, default: "primary"

      ## References
      t.references :institution, null: false, foreign_key: true, type: :bigint
      t.references :contact,     null: false, foreign_key: true, type: :bigint

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
