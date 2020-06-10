class Users::V1::Objects::AddressPresenter
  def self.to_json(address)
    return {} if address.nil?

    {
      id: address.id,
      street_line_1: address.street_line_1,
      street_line_2: address.street_line_2,
      city: address.city,
      state: address.state,
      zip_code: address.zip_code,
      country: address.country
    }
  end
end