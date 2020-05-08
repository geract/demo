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
      relationship: reference.relationship,
    }
  end

  private

  attr_reader :reference
end
