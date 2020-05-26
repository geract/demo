class Users::V1::Pets::IndexPresenter < BasePresenter
  def as_json(*)
    {
      pets: pets.map{ |pet| pets_attributes(pet) }
    }
  end

  private

  def pets_attributes(pet)
    attributes = Users::V1::Objects::PetPresenter.to_json(pet)
    attributes.merge({  favorite: false })
  end
end