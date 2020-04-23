class Inquery < ApplicationRecord
  validates :pet_id, :first_name, :last_name, :phone_number, :email, :city, :state, :reasons, presence: true
  validates :email, format: /\A[^@\s]+@[^@\s]+\z/
end
