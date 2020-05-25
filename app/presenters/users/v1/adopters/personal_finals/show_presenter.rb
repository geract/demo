class Users::V1::Adopters::PersonalFinals::ShowPresenter < BasePresenter
  def as_json(*)
    { 
      profile: {
        id: profile.id,
        pet_info_attributes: pet_info_attributes,
        veterinarian_attributes: Users::V1::Objects::Adopters::VeterinarianPresenter.to_json(profile.veterinarian)
      }
    }
  end

  private

  def pet_info_attributes
    pet_info = Users::V1::Objects::Adopters::PetInfoPresenter.to_json(profile.pet_info)
    pet_info.delete(:home)
    pet_info.delete(:lifestyle)
    
    pet_info
  end
end
