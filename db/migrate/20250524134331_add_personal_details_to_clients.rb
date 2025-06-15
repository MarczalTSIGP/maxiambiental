class AddPersonalDetailsToClients < ActiveRecord::Migration[8.0]
  def change
    add_column :clients, :cpf, :string
    add_column :clients, :phone, :string
    add_column :clients, :cep, :string
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :address, :text
    add_column :clients, :formation, :string
    add_column :clients, :current_company, :string

    add_index :clients, :cpf, unique: true, length: { cpf: 11 }
  end
end