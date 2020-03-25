class CreatePetInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :pet_infos do |t|
      t.jsonb :home
      t.jsonb :animal_history
      t.jsonb :lifestyle
      t.jsonb :personal
      t.jsonb :veterinarian_extra
      t.belongs_to :dog, foreign_key: { to_table: :pet_application_dogs }
      # t.string :type, null: false, index: true

      t.timestamps
    end
  end
end
