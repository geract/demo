class Users::V1::Adopters::Homes::ShowPresenter < BasePresenter
  def as_json(*)
    { 
      profile: {
        id: profile.id,
        pet_info_attributes: {
          home: home_info
        }
      }
    }
  end

  def home_info
    pet_info = Users::V1::Objects::PetInfoPresenter.to_json(profile.pet_info)

    {
      id: pet_info[:id],
      home: pet_info[:home]
    }
  end
end
