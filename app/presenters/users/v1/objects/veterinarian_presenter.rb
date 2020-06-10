class Users::V1::Objects::VeterinarianPresenter
  def self.to_json(veterinarian)
    return {} if veterinarian.blank?

    {
      id: veterinarian.id,
      first_name: veterinarian.first_name,
      last_name: veterinarian.last_name,
      email: veterinarian.email,
      phone_number: veterinarian.phone_number,
      address_attributes: Users::V1::Objects::AddressPresenter.to_json(veterinarian.address)
    }
  end
end