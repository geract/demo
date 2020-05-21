class Users::V1::Rescuers::PetApplicationsStatusesController < Users::V1::Rescuers::BaseController
  def update
    pet_application = current_organization.pet_applications.find(
      params[:id]
    )

    if Rescuer::UpdatePetApplicationStatusService.perform(
      pet_application,
      pet_application_params
    )
      head :ok
    else
      render json: pet_application.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def pet_application_params
    params.require(:pet_application).permit(:status, rejection_details: {})
  end
end
