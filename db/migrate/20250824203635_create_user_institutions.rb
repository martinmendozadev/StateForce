class CreateUserInstitutions < ActiveRecord::Migration[8.0]
  def change
    create_table :user_institutions, primary_key: [ :user_id, :institution_id ] do |t|
      t.string :position, limit: 50, default: "member"
      t.enum :role, enum_type: "role", null: false, default: "guest"
      t.enum :status, enum_type: "status_invite", null: false, default: "draft"

      ## References
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :institution, null: false, foreign_key: { to_table: :institutions }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
