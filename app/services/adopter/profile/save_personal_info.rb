# frozen_string_literal: true

class Adopter::Profile::SavePersonalInfo
  attr_reader :profile

  def initialize(adopter, params)
    @profile = adopter.profile || adopter.build_profile
    @attributes = params
    @pet_info_attributes = attributes.delete(:pet_info_attributes)
    @has_co_adopter = (attributes.delete(:has_co_adopter) == 'true')
  end

  def perform
    profile.transaction do
      profile.assign_attributes(attributes)
      set_pet_info
      update_profile_state

      profile.save
    end
  end

  private

  attr_reader :attributes, :pet_info_attributes, :has_co_adopter

  def set_pet_info
    if profile.pet_info
      profile.pet_info.assign_attributes(pet_info_attributes)
    else
      profile.pet_info = PetInfo.new(pet_info_attributes)
    end
  end

  def update_profile_state
    if profile.personal_info?
      if has_co_adopter
        profile.continue!
      else
        profile.skip_co_adopter!
      end
    end
  end
end
