class Users::Adopters::Profile::LifestylePresenter
  def initialize(adopter)
    @profile = adopter.profile
    @pet_info = profile.pet_info
  end

  def as_json(*)
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          lifestyle: lifestyle_info
        }
      }
    }
  end

  private

  attr_reader :profile, :pet_info

  def lifestyle_info
    Users::Adopters::PetInfoPresenter.new(pet_info).response.select do |field|
      [:id, :lifestyle].include?(field)
    end
  end
end
