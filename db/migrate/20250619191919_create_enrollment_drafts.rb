class CreateEnrollmentDrafts < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollment_drafts do |t|
      t.string :current_step, default: 'client'
      t.jsonb :client
      t.jsonb :enrollment
      t.jsonb :payment
      
      t.timestamps
    end
  end
end
