class AddOrganizationAndAddedToPets < ActiveRecord::Migration[6.0]
  def change
    add_reference :pets, :organization, foreign_key: true
    add_column :pets, :added_by_id, :integer, foreign_key: true
  end
end
