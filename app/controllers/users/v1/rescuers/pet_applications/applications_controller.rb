class Users::V1::Rescuers::PetApplications::ApplicationsController < Users::V1::Rescuers::BaseController
  def show
    pet_application = current_organization.pet_applications.includes(adopter_profile: :references).find(safe_params[:pet_application_id])

    render json: Users::Adopters::ApplicationPresenter.new(pet_application.adopter_profile).response, status: :ok
  end

  private

  def safe_params
    params.permit(:pet_application_id)
  end
end
