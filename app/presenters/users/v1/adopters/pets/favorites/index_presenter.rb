class Users::V1::Adopters::Pets::Favorites::IndexPresenter < BasePresenter
  def as_json(*)
    {
      pets: pets.map{ |pet| Users::V1::Objects::PetPresenter.to_json(pet) }
    }
  end
end
