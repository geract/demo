class AddRejectionDetailsToPetApplication < ActiveRecord::Migration[6.0]
  def change
    add_column :pet_applications, :rejection_details, :json
    add_column :pet_applications, :rejected_at, :datetime
  end
end
