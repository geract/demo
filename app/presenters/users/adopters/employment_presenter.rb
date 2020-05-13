class Users::Adopters::EmploymentPresenter
  def initialize(employment)
    @employment = employment
  end

  def response
    return {} unless employment
    {
      id: employment.id,
      status: employment.status,
      years: employment.years,
      company: employment.company,
      pet_costs: employment.pet_costs,
      address_attributes: Users::Adopters::AddressPresenter.new(employment.address).response
    }
  end

  private

  attr_reader :employment
end
