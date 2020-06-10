class Users::V1::Rescuers::Pets::PetApplications::IndexPresenter < BasePresenter
  def as_json(*)
    applications.map do |application|
      {
        id: application.id,
        favorite: application.favorite,
        adopter: Users::V1::Objects::AdopterProfilePresenter.to_json(application.adopter_profile),
        created_at: application.created_at
      }
    end
  end
end