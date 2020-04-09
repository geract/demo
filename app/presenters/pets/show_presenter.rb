class Pets::ShowPresenter
  def initialize(pet)
    @pet = pet
  end

  def as_json(*)
    response = PetPresenter.new(pet).response
    response.merge({
      status: pet.status,
      birthdate: pet.birthdate,
      fee: pet.fee,
      description: pet.description,
      organization_id: pet.organization_id,
      organization_name: pet.organization_name,
    })
  end

  private

  attr_reader :pet
end