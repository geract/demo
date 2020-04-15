class CreateAdopterProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :adopter_profiles do |t|
      t.string :pronoun
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :family_status
      t.string :state, null: false
      t.string :phone_number
      t.jsonb :preferences, null: false, default: {}
      t.boolean :terms
      t.boolean :home_visit_agreement
      t.boolean :adoption_fee_agreement
      
      t.belongs_to :adopter, foreign_key: { to_table: :users }, index: { unique: true }
      t.belongs_to :co_adopter, foreign_key: { to_table: :users }
      t.belongs_to :applicationable, polymorphic: true, index: { name: :index_applications_on_applicationable_type_and_id }
      t.belongs_to :veterinarian, foreign_key: true

      t.timestamps
    end
  end
end
