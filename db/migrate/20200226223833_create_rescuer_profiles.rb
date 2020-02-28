class CreateRescuerProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :rescuer_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :title
      t.string :type
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
