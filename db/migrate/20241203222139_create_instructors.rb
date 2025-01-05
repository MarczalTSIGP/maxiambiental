class CreateInstructors < ActiveRecord::Migration[7.1]
  def change
    create_table :instructors do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.boolean :active, default: true, null: false
      t.text :resume

      t.timestamps
    end

    add_index :instructors, :email, unique: true
    add_index :instructors, :name
  end
end
