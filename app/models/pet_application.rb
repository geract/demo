class PetApplication < ApplicationRecord
  include PetApplications::StateManager

  belongs_to :pet
  belongs_to :adopter_profile
  belongs_to :organization

  scope :favorites, -> { where(favorite: true) }
  scope :remove_filters, -> { unscope(:where) }

  def time_listed
    return "#{days_listed} days" if days_listed > 0

    "#{(days_listed / 1).hour} hours"
  end

  private

  def days_listed
    @days_listed ||= (Time.now - created_at).to_i
  end
end
