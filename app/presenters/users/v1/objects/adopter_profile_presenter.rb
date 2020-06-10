class Users::V1::Objects::AdopterProfilePresenter
  class << self
    def to_json(adopter_profile)
      @adopter_profile = adopter_profile

      {
        id: adopter_profile.id,
        first_name: adopter_profile.first_name,
        last_name: adopter_profile.last_name,
        phone_number: adopter_profile.phone_number,
        email: adopter_profile.email,
        pronoun: adopter_profile.pronoun,
        family_status: adopter_profile.family_status,
        birthday: adopter_profile.birthday,
        address_attributes: Users::V1::Objects::AddressPresenter.to_json(adopter_profile.address),
        employment_attributes: Users::V1::Objects::EmploymentPresenter.to_json(adopter_profile.employment),
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

    private

    attr_reader :adopter_profile

    def references
      adopter_profile.references.map do |reference|
        Users::V1::Objects::ReferencePresenter.to_json(reference)
      end
    end
  end
end
