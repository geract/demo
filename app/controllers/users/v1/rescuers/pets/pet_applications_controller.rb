class Users::V1::Rescuers::Pets::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pet = current_organization.pets.find_by(id: params[:pet_id])
    
    if pet
      applications = unless filter_params.blank?
        pet.applications.includes(adopter_profile: :address)
      else
        pet.applications.includes(adopter_profile: :address).where(filter_params)
      end
  
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
