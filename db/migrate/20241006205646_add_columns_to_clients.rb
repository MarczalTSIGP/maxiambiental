class AddColumnsToClients < ActiveRecord::Migration[7.1]
  def change
    change_table :clients, bulk: true do |t|
      t.string :name
      t.boolean :active, default: true
      t.text :bio

      t.string :provider
      t.string :uid

      t.index :name
    end
  end
end
