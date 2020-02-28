class RemoveProfileFieldsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :phone, :string
  end
end
