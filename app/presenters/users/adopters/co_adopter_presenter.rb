class Users::Adopters::CoAdopterPresenter
  def initialize(co_adopter)
    @co_adopter = co_adopter
  end

  def response
    return {} unless co_adopter
    {
      id: co_adopter.id,
      email: co_adopter.email,
      first_name: co_adopter.first_name,
      last_name: co_adopter.last_name,
      phone_number: co_adopter.phone_number,
      birthday: co_adopter.birthday,
      address_attributes: Users::Adopters::AddressPresenter.new(co_adopter.address).response,
      employment_attributes: Users::Adopters::EmploymentPresenter.new(co_adopter.employment).response
    }
  end

  private

  attr_reader :co_adopter
end
