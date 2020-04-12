# frozen_string_literal: true

class Adopter::Profile::SavePersonalInfo
  attr_reader :profile

  def initialize(adopter, params)
    @profile = adopter.profile
    @attributes = params
    @pet_info_attributes = attributes.delete(:pet_info_attributes)
    @has_co_adopter = attributes.delete(:has_co_adopter)
  end

  def perform
    profile.transaction do
      profile.assign_attributes(attributes)

      PetInfo.find_or_initialize_by(adopter_profile_id: profile.id).
              assign_attributes(pet_info_attributes)
      
      has_co_adopter && profile.continue! || profile.skip_co_adopter!
      profile.save
    end
  end

  private

  attr_reader :attributes, :pet_info_attributes, :has_co_adopter
end
