class CreateVeterinarians < ActiveRecord::Migration[5.2]
  def change
    create_table :veterinarians do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.belongs_to :address, foreign_key: { to_table: :adopter_addresses }

      t.timestamps
    end
  end
end
