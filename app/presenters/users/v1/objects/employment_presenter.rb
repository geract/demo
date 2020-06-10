class Users::V1::Objects::EmploymentPresenter
  def self.to_json(employment)
    return {} if employment.blank?

    {
      id: employment.id,
      status: employment.status,
      years: employment.years,
      company: employment.company,
      pet_costs: employment.pet_costs,
      address_attributes: Users::V1::Objects::AddressPresenter.to_json(employment.address)
    }
  end
end