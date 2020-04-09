class CreatePetApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :pet_applications do |t|
      t.belongs_to :adopter, foreign_key: { to_table: :users }
      t.belongs_to :co_adopter, foreign_key: { to_table: :users }
      t.belongs_to :applicationable, polymorphic: true, index: { name: :index_applications_on_applicationable_type_and_id }
      t.belongs_to :veterinarian, foreign_key: true
      t.belongs_to :pet, foreign_key: true

      t.string :state, null: false

      t.boolean :home_visit_agreement
      t.boolean :adoption_fee_agreement
      
      t.timestamps
    end
  end
end
