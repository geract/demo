class Users::V1::Pets::ShowPresenter < BasePresenter
  def as_json(*)
    {
      pet: pet_response
    }
  end

  private

  def pet_response
    pet_hash = Users::V1::Objects::PetPresenter.to_json(pet)
    pet_hash.merge({
      status: pet.status,
      birthdate: pet.birthdate,
      fee: pet.price, #change this to price
      description: pet.description,
      organization_id: pet.organization_id,
      organization_name: pet.organization_name,
    })
  end
end