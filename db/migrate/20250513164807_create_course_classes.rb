class CreateCourseClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :course_classes do |t|
      t.string :name, null: false
      t.date :start_at, null: false
      t.date :end_at, null: false
      t.integer :subscription_status, default: 0
      t.text :schedule
      t.boolean :active, default: true
      t.belongs_to :course, null: false, foreign_key: { on_delete: :restrict }
      t.belongs_to :instructor, null: false, foreign_key: { on_delete: :restrict }
      t.timestamps

      t.index [:course_id, :name], unique: true
      t.index [:instructor_id, :start_at]
    end
  end
end