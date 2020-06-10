class Users::V1::Objects::ApplicationPresenter
  def self.to_json(adopter_profile)
    return {} unless adopter_profile

    {
      co_adopter: Users::V1::Objects::CoAdopterPresenter.to_json(adopter_profile.co_adopter),
      pet_info: Users::V1::Objects::PetInfoPresenter.to_json(adopter_profile.pet_info),
      veterinarian: Users::V1::Objects::VeterinarianPresenter.to_json(adopter_profile.veterinarian)
    }
  end
end
