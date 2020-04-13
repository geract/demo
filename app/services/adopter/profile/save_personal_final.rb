# frozen_string_literal: true

class Adopter::Profile::SavePersonalFinal
  attr_reader :profile

  def initialize(adopter, params)
    @profile = adopter.profile
    @attributes = params
    @veterinarian_attributes = attributes.delete(:veterinarian_attributes)
    @has_veterinarian = (attributes[:pet_info_attributes][:veterinarian_extra][:has_veterinarian] == 'true')
  end

  def perform
    profile.transaction do
      set_veterinarian
      set_pet_info

      profile.personal_final? && profile.continue!
      profile.save
    end
  end

  private

  attr_reader :attributes, :veterinarian_attributes, :has_veterinarian

  def set_veterinarian
    if has_veterinarian
      if profile.veterinarian
        profile.veterinarian.assign_attributes(veterinarian_attributes)
      else
        profile.veterinarian = Veterinarian.new(veterinarian_attributes)
      end
    else
      profile.veterinarian = nil
    end
  end

  def set_pet_info
    profile.pet_info.personal = profile.pet_info.personal.merge(attributes[:pet_info_attributes][:personal])
    profile.pet_info.animal_history = profile.pet_info.animal_history.merge(attributes[:pet_info_attributes][:animal_history])
    profile.pet_info.veterinarian_extra = profile.pet_info.veterinarian_extra.merge(attributes[:pet_info_attributes][:veterinarian_extra])
  end
end
