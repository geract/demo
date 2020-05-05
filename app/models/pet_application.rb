class PetApplication < ApplicationRecord
  include PetApplications::StateManager

  belongs_to :pet
  belongs_to :adopter_profile
  belongs_to :organization

  scope :favorites, -> { where(favorite: true) }
  scope :remove_filters, -> { unscope(:where) }
end
