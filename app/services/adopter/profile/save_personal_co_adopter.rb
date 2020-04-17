# frozen_string_literal: true

class Adopter::Profile::SavePersonalCoAdopter
  class << self    
    def perform(profile, params)
      @profile = profile
      @is_address_same_as_adopter = (params.delete(:is_address_same_as_adopter) == 'true')
      pet_info_attributes = params.delete(:pet_info_attributes)

      set_pet_info(pet_info_attributes)
      profile.assign_attributes(params)
      profile.transaction do
        saved = profile.save
        saved_callbacks if saved
        saved
      end
    end

    def saved_callbacks
      update_co_adopter_address
      profile.personal_co_adopter? && profile.continue!
    end

    private

    attr_reader :personal_attributes, :attributes, :is_address_same_as_adopter, :profile, :co_adopter

    def update_co_adopter_address
      co_adopter.address = profile.address if is_address_same_as_adopter == 'true'
    end

    def set_pet_info(pet_info_attributes)
      profile.pet_info.personal = profile.pet_info.personal.merge(pet_info_attributes[:personal])
    end
  end
end
