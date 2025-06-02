class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.references :client, null: false, foreign_key: true
      t.references :course_class, null: false, foreign_key: true

      t.text :notes
      t.string :category
      t.string :status, default: 'pending'
      t.text :referral_source
      t.boolean :previous_participation
      t.boolean :terms_accepted, null: false
      
      t.timestamps

      t.index [:client_id, :course_class_id], unique: true
    end
  end
end
