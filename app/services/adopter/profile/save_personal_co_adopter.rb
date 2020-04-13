# frozen_string_literal: true

class Adopter::Profile::SavePersonalCoAdopter
  attr_reader :profile

  def initialize(adopter, params)
    @profile = adopter.profile

    return false unless params[:co_adopter_attributes].present?

    @personal_attributes = params[:pet_info_attributes][:personal]
    @co_adopter_attributes = params.delete(:co_adopter_attributes).merge(password: generate_password)
    @co_adopter_attributes[:profile_attributes][:is_from_co_adopter] = true

    @is_address_same_as_adopter = (params.delete(:is_address_same_as_adopter) == 'true')
  end
  
  def perform
    profile.transaction do
      set_co_adopter
      set_pet_info

      profile.personal_co_adopter? && profile.continue!
      profile.save
    end
  end

  private

  attr_reader :personal_attributes, :co_adopter_attributes, :is_address_same_as_adopter

  def generate_password
    verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
    verifier.generate("#{Time.now}").first(20)
  end

  def set_co_adopter
    if profile.co_adopter
      profile.co_adopter.assign_attributes(co_adopter_attributes)
    else
      profile.co_adopter = Adopter.new(co_adopter_attributes)
    end
    
    profile.co_adopter.profile.address = profile.address if is_address_same_as_adopter
  end

  def set_pet_info
    profile.pet_info.personal = profile.pet_info.personal.merge(personal_attributes)
  end
end
