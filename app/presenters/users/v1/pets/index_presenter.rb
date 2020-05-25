class Users::V1::Pets::IndexPresenter < BasePresenter
  def as_json(*)
    {
      pets: pets.map{ |pet| Users::V1::Objects::PetPresenter.to_json(pet) }
    }
  end
end