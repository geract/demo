class Users::V1::Rescuers::Pets::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pet = current_organization.pets.friendly.find(params[:pet_id])
    
    applications = pet.applications.includes(adopter_profile: :address)
    applications = applications.favorites unless filter_params.blank?

    render json: Rescuers::Pets::PetApplications::IndexPresenter.new(applications), status: :ok
  end

  private

  def filter_params
    return {} unless params[:filters]

    params.require(:filters).permit(:favorite)
  end
end
