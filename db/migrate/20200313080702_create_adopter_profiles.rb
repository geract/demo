class CreateAdopterProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :adopter_profiles do |t|
      t.string :pronoun
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :family_status
      t.string :phone_number
      t.jsonb :preferences, null: false, default: {}
      t.boolean :terms
      t.boolean :home_visit_agreement
      t.boolean :adoption_fee_agreement
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
