class Users::V1::Rescuers::PetApplications::ApplicationsController < Users::V1::Rescuers::BaseController
  def show
    pet_application = current_organization.pet_applications.includes(adopter_profile: :references).find(params[:pet_application_id])

    response_with_presenter(adopter_profile: pet_application.adopter_profile)
    # render json: Users::Adopters::ApplicationPresenter.new(pet_application.adopter_profile).response, status: :ok
  end
end
