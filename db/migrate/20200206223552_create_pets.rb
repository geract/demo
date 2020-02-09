class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :external_id
      t.string :external_type, index: true
      t.string :pet_type, index: true

      t.timestamps
    end
  end
end
