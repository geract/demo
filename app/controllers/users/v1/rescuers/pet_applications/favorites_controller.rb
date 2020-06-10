class Users::V1::Rescuers::PetApplications::FavoritesController < Users::V1::Rescuers::BaseController
  def create
    update_pet_application(true)
  end
  
  def destroy
    update_pet_application(false)
  end

  private

  def update_pet_application(favorite)
    pet_application = current_organization.pet_applications.find(params[:pet_application_id])

    if pet_application.update(favorite: favorite)
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
