class CreatePetApplicationDog < ActiveRecord::Migration[6.0]
  def change
    create_table :pet_application_dogs do |t|
      t.string :state, null: false, default: 'personal_info'
    end
  end
end
