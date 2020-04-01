class CreateInqueries < ActiveRecord::Migration[6.0]
  def change
    create_table :inqueries do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :city
      t.string :state
      t.text :reasons
      t.belongs_to :pet

      t.timestamps
    end
  end
end
