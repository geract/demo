class CreateJoinTableFavoritePet < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites, id: false do |t|
      t.bigint :pet_id
      t.bigint :user_id
    end

    add_index :favorites, [:pet_id, :user_id], unique: true
  end
end
