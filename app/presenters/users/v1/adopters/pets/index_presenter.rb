class Users::V1::Adopters::Pets::IndexPresenter < BasePresenter
  def as_json(*)
    {
      pets: pets.map{ |pet| pets_attributes(pet) }
    }
  end

  private

  def pets_attributes(pet)
    attributes = Users::V1::Objects::PetPresenter.to_json(pet)
    attributes.merge({  favorite: pet.favorite_of_adopter?(current_user.id) })
  end
end