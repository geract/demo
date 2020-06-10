class Users::V1::Rescuers::Pets::ShowPresenter < BasePresenter
  def as_json(*)
    {
      pet: Users::V1::Objects::RescuerPetPresenter.to_json(pet)
    }
  end
end