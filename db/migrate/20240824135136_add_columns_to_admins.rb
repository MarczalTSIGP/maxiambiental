class AddColumnsToAdmins < ActiveRecord::Migration[7.1]
  def change
    change_table :admins, bulk: true do |t|
      t.string :name
      t.boolean :master, default: false, null: false
      t.text :bio
      t.string :avatar
      t.boolean :active, default: true, null: false

      t.index :name
    end
  end
end
