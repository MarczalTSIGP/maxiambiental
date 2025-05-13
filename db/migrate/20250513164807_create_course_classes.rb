class CreateCourseClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :course_classes do |t|
      t.string :name, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.string :period
      t.boolean :active, default: true
      t.string :address
      t.string :city
      t.belongs_to :course, null: false, foreign_key: { on_delete: :restrict }
      t.belongs_to :instructor, null: false, foreign_key: { on_delete: :restrict }
      t.timestamps

      t.index [:course_id, :name], unique: true
      t.index [:instructor_id, :start_at]
      t.check_constraint "end_at > start_at", name: "end_after_start_check"
    end
  end
end