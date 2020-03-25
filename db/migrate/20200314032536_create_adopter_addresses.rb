class CreateAdopterAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :adopter_addresses do |t|
      t.references :addressable, polymorphic: true, null: false
      t.string :street_line_1
      t.string :street_line_2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country

      t.timestamps
    end
  end
end
