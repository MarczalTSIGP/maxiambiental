class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.boolean :active, default: true
      t.text :description

      t.timestamps

      t.index :name
    end
  end
end
