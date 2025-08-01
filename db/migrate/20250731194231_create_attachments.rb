class CreateAttachments < ActiveRecord::Migration[8.0]
  def up
    # Postgres native ENUMs
    execute <<-SQL
      CREATE TYPE file_type AS ENUM ('certification', 'document', 'image', 'other', 'video');
    SQL

    execute <<-SQL
      CREATE TYPE visibility AS ENUM ('public', 'private', 'restricted');
    SQL

    create_table :attachments do |t|
      ## Custom fields
      t.string  :content_type, limit: 25
      t.text    :description
      t.string  :file_name, limit: 75
      t.bigint  :file_size

      t.column  :file_type, :file_type, null: false, default: 'other'
      t.string  :file_url, null: false
      t.column  :visibility, :visibility, null: false, default: 'private'

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

  def down
    ## Reverse the migration in case of rollback
    change_table :users do |t|
      t.string :avatar_url
      t.remove_references :avatar, foreign_key: true
    end

    drop_table :attachments

    execute "DROP TYPE file_type;"
    execute "DROP TYPE visibility;"
  end
end
