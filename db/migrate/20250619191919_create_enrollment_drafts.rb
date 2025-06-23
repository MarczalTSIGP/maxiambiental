class CreateEnrollmentDrafts < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollment_drafts do |t|
      t.references :client, null: false, foreign_key: true
      t.references :course_class, null: false, foreign_key: true
      t.string :current_step, default: 'client'
      t.jsonb :client_data
      t.jsonb :enrollment_data
      t.jsonb :payment_data
      
      t.timestamps

      t.index [:client_id, :course_class_id], unique: true
    end
  end
end
