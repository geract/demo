class Users::Adopters::Profile::HomePresenter
  def initialize(adopter)
    @profile = adopter.profile
    @pet_info = profile.pet_info
  end

  def as_json(*)
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          home: home_info
        }
      }
    }
  end

  private
  
  attr_reader :profile, :pet_info

  def home_info
    Users::Adopters::PetInfoPresenter.new(pet_info).response.select do |field|
      [:id, :home].include?(field)
    end
  end
end
