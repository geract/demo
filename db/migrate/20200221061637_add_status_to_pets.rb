class AddStatusToPets < ActiveRecord::Migration[6.0]
  def change
    add_column :pets, :status, :string, default: "created"
    add_column :pets, :reason_code, :integer
  end
end
