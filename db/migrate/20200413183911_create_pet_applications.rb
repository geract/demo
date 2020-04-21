class CreatePetApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :pet_applications do |t|
      t.belongs_to :pet, foreign_key: true, null: false
      t.belongs_to :adopter_profile, foreign_key: true, null: false
      t.string :status

      t.timestamps
    end
  end
end
