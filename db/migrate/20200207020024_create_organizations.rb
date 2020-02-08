class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :director
      t.string :description
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :'5013c'
      t.boolean :sheltered
      t.boolean :foster_based
      t.string :url
      t.string :email
      t.string :phone

      t.references :admin, null: false, foreign_key: true
      t.timestamps
    end
  end
end
