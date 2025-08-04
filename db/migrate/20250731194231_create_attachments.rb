class CreateAttachments < ActiveRecord::Migration[8.0]
  def change
    create_enum :file_type, %w[certification document image other video]
    create_enum :visibility, %w[public private restricted]

    create_table :attachments do |t|
      ## Custom fields
      t.string  :content_type, limit: 25
      t.text    :description
      t.string  :file_name, limit: 75
      t.bigint  :file_size

      t.enum :file_type, enum_type: "file_type", default: 'other', null: false
      t.string :file_url, null: false
      t.enum :visibility, enum_type: "visibility", default: "private", null: false

      ## References
      t.references :uploader_user, null: false, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end


    ## Update the users table to reference attachments
    change_table :users do |t|
      t.references :avatar, foreign_key: { to_table: :attachments }
      t.remove :avatar_url
    end
  end
end
