# frozen_string_literal: true

class Adopter::Profile::SavePersonalCoAdopter
  class << self
    def perform(profile, params)
      @profile = profile
      @is_address_same_as_adopter = ActiveModel::Type::Boolean.new.cast(params.delete(:is_address_same_as_adopter))
      
      pet_info_attributes = params.delete(:pet_info_attributes)
      set_pet_info(pet_info_attributes)

      profile.assign_attributes(params)
      profile.transaction do
        before_save_callbacks
        saved = profile.save
        saved_callbacks if saved
        saved
      end
    end
    
    private
    
    attr_reader :profile, :is_address_same_as_adopter
    
    def before_save_callbacks
      # Destroy co_adopter if exists, otherwise set the empty object passed through params as nil
      if is_address_same_as_adopter
        if profile.co_adopter&.address == profile.address
          profile.co_adopter.address = nil
        else
          profile.co_adopter.address.destroy
        end
      end
    end

    def saved_callbacks
      update_co_adopter_address
      profile.personal_co_adopter? && profile.continue!
    end

    def update_co_adopter_address
      profile.co_adopter.address = profile.address if is_address_same_as_adopter
    end

    def set_pet_info(pet_info_attributes)
      profile.pet_info.personal = profile.pet_info.personal.merge(pet_info_attributes[:personal])
    end
  end
end
