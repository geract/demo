class CreateNewMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :message
      t.references :senderable, polymorphic: true, null: false
      t.references :pet_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
