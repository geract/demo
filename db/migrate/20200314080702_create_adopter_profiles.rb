class CreateAdopterProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :adopter_profiles do |t|
      t.belongs_to :adopter, foreign_key: { to_table: :users }, index: { unique: true }
      t.jsonb :preferences, null: false, default: {}
      t.string :first_name
      t.string :last_name
      t.string :pronoun
      t.string :family_status
      t.string :phone_number
      t.date :birthday
      t.boolean :terms

      t.timestamps
    end
  end
end
