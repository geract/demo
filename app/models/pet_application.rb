class PetApplication < ApplicationRecord
  include PetApplications::StateManager

  belongs_to :pet
  belongs_to :adopter_profile
  belongs_to :organization
  has_many :messages, dependent: :destroy

  scope :favorites, -> { where(favorite: true) }
  scope :remove_filters, -> { unscope(:where) }

  validates :adopter_profile_id, uniqueness: { scope: :pet_id }
end
