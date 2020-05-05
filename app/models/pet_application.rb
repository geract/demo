class PetApplication < ApplicationRecord
  include ActionView::Helpers::DateHelper
  include PetApplications::StateManager

  belongs_to :pet
  belongs_to :adopter_profile
  belongs_to :organization

  scope :favorites, -> { where(favorite: true) }
  scope :remove_filters, -> { unscope(:where) }

  def time_listed
    @time_listed ||= distance_of_time_in_words(created_at, Time.now)
  end
end
