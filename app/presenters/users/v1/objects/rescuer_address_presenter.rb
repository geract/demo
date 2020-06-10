class Users::V1::Objects::RescuerAddressPresenter
  def self.to_json(address)
    return {} if address.nil?

    {
      name: address.name,
      address: address.address,
      city: address.city,
      state: address.state,
      zip_code: address.zip_code,
      main_location: address.main_location
    }
  end
end