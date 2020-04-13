class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :relationship
      t.belongs_to :adopter_profile, foreign_key: true

      t.timestamps
    end
  end
end
