class CreateInstructors < ActiveRecord::Migration[7.1]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :resume

      t.timestamps
    end
  end
end
