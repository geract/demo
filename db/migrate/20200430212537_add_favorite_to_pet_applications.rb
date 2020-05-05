class AddFavoriteToPetApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :pet_applications, :favorite, :boolean, default: false
    add_reference :pet_applications, :organization, index: true
  end
end
