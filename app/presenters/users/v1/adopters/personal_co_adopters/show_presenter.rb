class Users::V1::Adopters::PersonalCoAdopters::ShowPresenter < BasePresenter
  def as_json(*)
    return {} if co_adopter.blank?

    {
      profile: profile_info.merge(co_adopter_info)
    }
  end

  private

  def profile_info
    { 
      id: profile.id,
      is_address_same_as_adopter: profile.co_adopter&.address.nil?,
      pet_info_attributes: {
        id: pet_info.id,
        personal: {
          co_adopter_relation: pet_info.co_adopter_relation,
          pet_relation_change_owner: pet_info.pet_relation_change_owner
        }
      }
    }
  end

  def co_adopter_info
    {
      co_adopter_attributes: Users::V1::Objects::Adopters::CoAdopterPresenter.to_json(co_adopter)
    }
  end

  def co_adopter
    profile.co_adopter
  end

  def pet_info
    profile.pet_info
  end
end
