class CreateFavoritePets < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_pets do |t|
      t.references :pet, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    drop_table :favorites
    add_index :favorite_pets, [:pet_id, :user_id]
    add_index :favorite_pets, [:user_id, :pet_id]
  end
end
