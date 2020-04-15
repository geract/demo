class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :adopter_profile

  validates :pet, :adopter_profile, presence: true
end
