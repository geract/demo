class Users::V1::Adopters::Lifestyles::ShowPresenter < BasePresenter
  def as_json(*)
    { 
      profile: {
        id: profile.id,
        pet_info_attributes: {
          lifestyle: lifestyle_info
        }
      }
    }
  end

  private

  def lifestyle_info
    pet_info = Users::V1::Objects::Adopters::PetInfoPresenter.to_json(profile.pet_info)

    {
      id: pet_info[:id],
      lifestyle: pet_info[:lifestyle]
    }
  end
end
