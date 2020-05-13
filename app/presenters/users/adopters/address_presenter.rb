class Users::Adopters::AddressPresenter
  def initialize(address)
    @address = address
  end

  def response
    return {} unless address
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

  private

  attr_reader :address
end
