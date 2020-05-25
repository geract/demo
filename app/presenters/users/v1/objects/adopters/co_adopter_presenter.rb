class Users::V1::Objects::Adopters::CoAdopterPresenter
  def self.to_json(co_adopter)
    return {} if co_adopter.blank?

    {
      id: co_adopter.id,
      email: co_adopter.email,
      first_name: co_adopter.first_name,
      last_name: co_adopter.last_name,
      phone_number: co_adopter.phone_number,
      birthday: co_adopter.birthday,
      address_attributes: Users::V1::Objects::AddressPresenter.to_json(co_adopter.address),
      employment_attributes: Users::V1::Objects::Adopters::EmploymentPresenter.to_json(co_adopter.employment)
    }
  end
end
