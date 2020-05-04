# frozen_string_literal: true

class Adopter::Profile::SavePersonalFinal
  class << self
    def perform(profile, params)
      @profile = profile
      @params = params

      before_assign_callbacks
      profile.assign_attributes(params)
      profile.transaction do
        saved = profile.save
        saved_callbacks if saved
        saved
      end
    end
    
    private

    attr_reader :profile, :params

    def before_assign_callbacks
      pet_info_attributes = params.delete(:pet_info_attributes)
      set_pet_info(pet_info_attributes)

      has_veterinarian = ActiveModel::Type::Boolean.new.cast(pet_info_attributes[:veterinarian_extra][:has_veterinarian])

      # Destroy veterinarian if exists, otherwise set the empty object passed through params as nil
      unless has_veterinarian
        profile.veterinarian&.destroy || profile.veterinarian = nil
      end
    end

    def saved_callbacks
      profile.personal_final? && profile.continue!
    end

    def set_pet_info(pet_info_attributes)
      profile.pet_info.personal = profile.pet_info.personal.merge(pet_info_attributes[:personal])
      profile.pet_info.animal_history = profile.pet_info.animal_history.merge(pet_info_attributes[:animal_history])
      profile.pet_info.veterinarian_extra = profile.pet_info.veterinarian_extra.merge(pet_info_attributes[:veterinarian_extra])
    end
  end
end
