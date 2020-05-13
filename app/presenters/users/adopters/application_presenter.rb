class Users::Adopters::ApplicationPresenter
  def initialize(adopter_profile)
    @adopter_profile = adopter_profile
  end

  def response
    return {} unless adopter_profile
    {
      co_adopter: Users::Adopters::CoAdopterPresenter.new(adopter_profile.co_adopter).response,
      pet_info: Users::Adopters::PetInfoPresenter.new(adopter_profile.pet_info).response,
      veterinarian: Users::Adopters::VeterinarianPresenter.new(adopter_profile.veterinarian).response
    }
  end

  private

  attr_reader :adopter_profile
end
