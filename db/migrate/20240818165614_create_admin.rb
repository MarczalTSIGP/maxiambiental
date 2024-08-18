class CreateAdmin < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :master
      
      t.timestamps
    end
  end
end
