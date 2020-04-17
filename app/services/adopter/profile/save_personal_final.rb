# frozen_string_literal: true

class Adopter::Profile::SavePersonalFinal
  class << self
    def perform(profile, params)
      @profile = profile
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
      profile.personal_final? && profile.continue!
    end

    private

    attr_reader :profile

    def set_pet_info(pet_info_attributes)
      profile.pet_info.personal = profile.pet_info.personal.merge(pet_info_attributes[:personal])
      profile.pet_info.animal_history = profile.pet_info.animal_history.merge(pet_info_attributes[:animal_history])
      profile.pet_info.veterinarian_extra = profile.pet_info.veterinarian_extra.merge(pet_info_attributes[:veterinarian_extra])
    end
  end
end
