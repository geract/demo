class ReferencePresenter
  def initialize(reference)
    @reference = reference
  end

  def short_response
    {
      id: reference.id,
      first_name: reference.first_name,
      last_name: reference.last_name,
      email: reference.email,
      phone_number: reference.phone_number,
      relationship: reference.relationship
    }
  end

  def response
    short_response.merge({
      how_you_know: reference.how_you_know,
      years: reference.years,
      adopter_has_pets: reference.adopter_has_pets,
      adopter_pet_kind: reference.adopter_pet_kind,
      adopter_pet_treatment: reference.adopter_pet_treatment,
      adopter_pet_location: reference.adopter_pet_location,
      adopter_home_safe: reference.adopter_home_safe,
      adopter_has_children: reference.adopter_has_children, 
      adopter_pet_expectation: reference.adopter_pet_expectation,
      adopter_has_income: reference.adopter_has_income,
      adopter_reservations: reference.adopter_reservations,
      additional_information: reference.additional_information,
      interested_in_pets: reference.interested_in_pets,
    })
  end

  private

  attr_reader :reference
end
