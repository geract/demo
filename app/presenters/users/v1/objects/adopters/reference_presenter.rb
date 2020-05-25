class Users::V1::Objects::Adopters::ReferencePresenter
  def self.to_json(reference)
    {
      id: reference.id,
      first_name: reference.first_name,
      last_name: reference.last_name,
      email: reference.email,
      phone_number: reference.phone_number,
      relationship: reference.relationship
    }
  end
end