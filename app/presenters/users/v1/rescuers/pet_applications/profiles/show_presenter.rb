class Users::V1::Rescuers::PetApplications::Profiles::ShowPresenter < BasePresenter
  def as_json(*)
    Users::V1::Objects::AdopterProfilePresenter.to_json(adopter_profile)
  end
end
