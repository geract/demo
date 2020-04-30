class Users::Adopters::ProfilePresenter
  def initialize(adopter_profile)
    @adopter_profile = adopter_profile
  end

  def short_response
    {
      id: adopter_profile.id,
      first_name: adopter_profile.first_name,
      last_name: adopter_profile.last_name,
      address_attributes: {
        id: adopter_profile.address.id,
        city: adopter_profile.address.city,
        state: adopter_profile.address.state
      }
    }.compact
  end

  private

  attr_reader :adopter_profile
end
