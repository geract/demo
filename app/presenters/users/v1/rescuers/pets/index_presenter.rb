class Users::V1::Rescuers::Pets::IndexPresenter < BasePresenter
  def as_json(*)
    {
      pets: pets.map{|pet| Users::V1::Objects::RescuerPetPresenter.to_json(pet) }
    }
  end
end