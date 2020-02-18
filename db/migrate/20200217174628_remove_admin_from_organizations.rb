class RemoveAdminFromOrganizations < ActiveRecord::Migration[6.0]
  def change
    remove_reference :organizations, :admin, index: true
  end
end
