class Users::Adopters::Profile::PersonalFinalPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @veterinarian = profile.veterinarian
    @pet_info = profile.pet_info
  end
  
  def as_json(*)
    { profile: {
        id: profile.id,
        pet_info_attributes: pet_info_attributes,
        veterinarian_attributes: Users::Adopters::VeterinarianPresenter.new(veterinarian).response
      }
    }
  end

  private

  attr_reader :profile, :veterinarian, :pet_info

  def pet_info_attributes
    Users::Adopters::PetInfoPresenter.new(pet_info).response.reject do |field|
      [:home, :lifestyle].include?(field)
    end
  end
end
