class CreateVeterinarians < ActiveRecord::Migration[5.2]
  def change
    create_table :veterinarians do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.references :adopter_profile, foreign_key: true

      t.timestamps
    end
  end
end
