class AddLocationToPets < ActiveRecord::Migration[6.0]
  def change
    add_column :pets, :location, :string, null: false, default: ''
  end
end
