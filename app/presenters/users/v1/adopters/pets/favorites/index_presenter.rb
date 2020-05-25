class Users::V1::Adopters::Pets::Favorites::IndexPresenter < BasePresenter
  def as_json(*)
    {
      pets: pets.map{ |pet| PetObjectPresenter.to_json(pet) }
    }
  end
end
