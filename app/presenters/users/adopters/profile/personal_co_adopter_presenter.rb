class Users::Adopters::Profile::PersonalCoAdopterPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @co_adopter = profile.co_adopter
    @pet_info = profile.pet_info

    return {} if co_adopter.nil?
  end

  def as_json(*)
    {
      profile: profile_info.merge(co_adopter_info)
    }
  end

  private

  attr_reader :profile, :co_adopter, :pet_info

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
      co_adopter_attributes: Users::Adopters::CoAdopterPresenter.new(co_adopter).response
    }
  end
end
