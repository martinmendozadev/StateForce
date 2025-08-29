# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    ## Enums
    create_enum :visibility, %w[public private restricted]

    create_table :notes do |t|
      ## Custom fields
      t.text    :body, null: false
      t.string  :title, null: false
      t.enum    :visibility, enum_type: "visibility", default: "private", null: false

      ## References
      t.references :noteable, polymorphic: true, null: false
      t.references :creator_user, null: false, foreign_key: { to_table: :users }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
