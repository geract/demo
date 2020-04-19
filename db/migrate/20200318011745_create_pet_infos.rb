class CreatePetInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :pet_infos do |t|
      t.jsonb :home
      t.jsonb :animal_history
      t.jsonb :lifestyle
      t.jsonb :personal
      t.jsonb :veterinarian_extra
      t.references :adopter_profile, foreign_key: true

      t.timestamps
    end
  end
end
