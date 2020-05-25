class Users::V1::Pets::IndexPresenter < BasePresenter
  def as_json(*)
    {
      pets: pets.map{ |pet| PetObjectPresenter.to_json(pet) }
    }
  end
end