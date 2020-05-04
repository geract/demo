class PetApplication < ApplicationRecord
  include PetApplications::StateManager

  belongs_to :pet
  belongs_to :adopter_profile
end
