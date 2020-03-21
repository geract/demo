class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :sender_type
      t.bigint :sender_id
      t.bigint :pet_id
      t.bigint :organization_id
      t.text   :message

      t.timestamps
    end
  end
end
