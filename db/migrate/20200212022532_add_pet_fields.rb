class AddPetFields < ActiveRecord::Migration[6.0]
  def change
    add_column :pets, :price, :decimal, null: false
    add_column :pets, :microchip_provider, :string
    add_column :pets, :microchip_number, :string
    add_column :pets, :housed, :string
    add_column :pets, :breed, :string, null: false
    add_column :pets, :second_breed, :string
    add_column :pets, :sex, :string, null: false
    add_column :pets, :size, :string, null: false
    add_column :pets, :age, :string, null: false
    add_column :pets, :description, :text, null: false
    add_column :pets, :medical_history, :text
    add_column :pets, :foster_family, :text
    add_column :pets, :public, :boolean
    add_column :pets, :mix_breed, :boolean
    add_column :pets, :personality, :jsonb, null: false, default: '{}'
  end
end
