class AddColumnsToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.string :name
      t.text :bio
      t.string :avatar
      t.integer :role, default: 0
      t.boolean :active
    end
  end
end
