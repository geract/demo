class Users::Adopters::VeterinarianPresenter
  def initialize(veterinarian)
    @veterinarian = veterinarian
  end

  def response
    return {} unless veterinarian
    {
      id: veterinarian.id,
      first_name: veterinarian.first_name,
      last_name: veterinarian.last_name,
      email: veterinarian.email,
      phone_number: veterinarian.phone_number,
      address_attributes: Users::Adopters::AddressPresenter.new(veterinarian.address).response
    }
  end

  private

  attr_reader :veterinarian
end
