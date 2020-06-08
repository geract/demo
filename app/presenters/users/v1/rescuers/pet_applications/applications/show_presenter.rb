class Users::V1::Rescuers::PetApplications::Applications::ShowPresenter < BasePresenter
  def as_json(*)
    Users::V1::Objects::ApplicationPresenter.to_json(adopter_profile)
  end
end
