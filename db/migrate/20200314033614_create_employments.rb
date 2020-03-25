class CreateEmployments < ActiveRecord::Migration[6.0]
  def change
    create_table :employments do |t|
      t.references :employmentable, polymorphic: true, null: false
      t.string :status
      t.string :years
      t.string :company
      t.string :pet_costs

      t.timestamps
    end
  end
end
