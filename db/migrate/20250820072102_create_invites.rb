# frozen_string_literal: true

class CreateInvites < ActiveRecord::Migration[8.0]
  def change
    ## Enums
    create_enum :status_invite, %w[active accepted cancelled done draft expired paused pending retired revoked sent unknown]
    create_enum :role, %w[admin guest manager restricted standard superadmin]

    create_table :invites do |t|
      ## Custom fields
      t.string    :email
      t.datetime  :expires_at, null: false
      t.bigint    :inviter_id
      t.enum      :role, enum_type: :role, null: false, default: "guest"
      t.enum      :status, enum_type: :status_invite, null: false, default: "draft"
      t.string    :token, null: false
      t.datetime  :used_at

      ## References
      t.references :institution, null: false, foreign_key: { to_table: :institutions }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end

    ## Others
    add_foreign_key :invites, :users, column: :inviter_id
    add_index :invites, [ :token ], unique: true
  end
end
