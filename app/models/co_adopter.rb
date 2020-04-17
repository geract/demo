class CoAdopter < ApplicationRecord
  belongs_to :adopter_profile
  has_one :address, class_name: "AdopterAddress", as: :addressable, dependent: :destroy
  has_one :employment, as: :employmentable, dependent: :destroy

  validates :email, :phone_number, :first_name, :last_name, presence: true
end
