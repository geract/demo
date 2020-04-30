class Users::V1::Rescuers::Pets::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pet = current_organization.pets.includes(applications: :adopter_profile).find_by(id: params[:pet_id])

    if pet
      render json: Rescuers::Pets::PetApplications::IndexPresenter.new(pet.applications), status: :ok
    else
      head :unprocessable_entity
    end
  end
end
