class Users::V1::Rescuers::PetApplications::ProfilesController < Users::V1::Rescuers::BaseController
  def show
    pet_application = current_organization.pet_applications.includes(adopter_profile: :references).find(safe_params[:pet_application_id])

    response_with_presenter(adopter_profile: pet_application.adopter_profile)
  end

  private

  def safe_params
    params.permit(:pet_application_id)
  end
end
