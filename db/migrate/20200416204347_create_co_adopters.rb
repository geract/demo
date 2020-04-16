class CreateCoAdopters < ActiveRecord::Migration[6.0]
  def change
    create_table :co_adopters do |t|
      t.string :phone_number
      t.string :birthday
      t.string :first_name
      t.string :last_name
      t.references :adopter_profile, foreign_key: true

      t.timestamps
    end
  end
end
