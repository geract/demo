class Users::Adopters::ProfilePresenter
  def initialize(adopter_profile)
    @adopter_profile = adopter_profile
  end

  def response
    {
      id: adopter_profile.id,
      phone_number: adopter_profile.phone_number,
      email: adopter_profile.email,
      pronoun: adopter_profile.pronoun,
      family_status: adopter_profile.family_status,
      birthday: adopter_profile.birthday,
      address_attributes: Users::Adopters::AddressPresenter.new(adopter_profile.address).response,
      employment_attributes: Users::Adopters::EmploymentPresenter.new(adopter_profile.employment).response,
      preferences: {
        age: adopter_profile.age,
        sex: adopter_profile.sex,
        size: adopter_profile.size,
        hair: adopter_profile.hair,
        energy: adopter_profile.energy,
        breed: adopter_profile.breed,
        special_needs: adopter_profile.special_needs
      },
      references: references
    }
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

  def references
    adopter_profile.references.map do |reference|
      ::ReferencePresenter.new(reference).response
    end
  end
end
