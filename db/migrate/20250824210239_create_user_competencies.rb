class CreateUserCompetencies < ActiveRecord::Migration[8.0]
  def change
    create_table :user_competencies, primary_key: [ :user_id, :competency_id ] do |t|
      t.date :expiry_date

      ## References
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :competency, null: false, foreign_key: { to_table: :competencies }

      ## Timestamps and soft delete
      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
