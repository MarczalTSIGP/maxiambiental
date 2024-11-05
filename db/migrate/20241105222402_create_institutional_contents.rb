class CreateInstitutionalContents < ActiveRecord::Migration[7.1]
  def change
    create_table :institutional_contents do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
