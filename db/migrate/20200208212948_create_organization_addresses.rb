class CreateOrganizationAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_addresses do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.boolean :main_location
      t.string :type

      t.references :organization, null: false, foreign_key: true
      t.timestamps
    end
  end
end
