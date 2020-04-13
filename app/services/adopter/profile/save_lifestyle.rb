# frozen_string_literal: true

class Adopter::Profile::SaveLifestyle
  attr_reader :profile

  def initialize(adopter, params)
    @profile = adopter.profile
    @attributes = params
  end
  
  def perform
    profile.transaction do
      profile.pet_info.lifestyle = profile.pet_info.lifestyle.merge(attributes)

      profile.lifestyle? && profile.continue!
      profile.save
    end
  end

  private

  attr_reader :attributes
end
