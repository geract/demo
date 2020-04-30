class Users::V1::Rescuers::Pets::FavoriteApplicationsController < Users::V1::Rescuers::BaseController
  def update
    update_pet_application(true)
  end
  
  def destroy
    update_pet_application(false)
  end

  private

  def update_pet_application(favorite)
    pet = current_organization.pets.includes(:applications).find_by(id: safe_params[:pet_id])
    pet_application = pet.applications.find_by(id: safe_params[:id]) if pet

    if pet && pet_application&.update(favorite: favorite)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def safe_params
    params.permit(:pet_id, :id)
  end
end
