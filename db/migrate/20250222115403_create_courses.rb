class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.boolean :active, default: true

      t.timestamps

      t.index :name
    end
  end
end
