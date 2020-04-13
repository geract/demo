# frozen_string_literal: true

class Adopter::Profile::SaveHome
  attr_reader :profile

  def initialize(adopter, params)
    @profile = adopter.profile
    @home_attributes = params[:pet_info_attributes][:home]
  end

  def perform
    @profile.transaction do
      profile.pet_info.personal = profile.pet_info.personal.merge(home_attributes)

      profile.home? && profile.continue!
      profile.save
    end
  end

  private

  attr_reader :home_attributes
end
