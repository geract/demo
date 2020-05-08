class Users::V1::Rescuers::Pets::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pet = current_organization.pets.friendly.find(params[:pet_id])
    
    if pet
      applications = pet.applications.includes(adopter_profile: :address).favorites
      applications = applications.remove_filters if filter_params.blank?

      render json: Rescuers::Pets::PetApplications::IndexPresenter.new(applications), status: :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def filter_params
    return {} unless params[:filters]

    params.require(:filters).permit(:favorite)
  end
end
