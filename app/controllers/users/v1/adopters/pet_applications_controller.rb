class Users::V1::Adopters::PetApplicationsController < Users::V1::Adopters::BaseController
  def create
    pet = Pet.find_by(id: pet_application_params[:pet_id])
    pet_application = PetApplication.new(pet_application_params.merge(organization: pet&.organization))

    if pet_application.save
      head :ok
    else
      render json: {errors: pet_application.errors.messages}, status: :unprocessable_entity
    end
  end

  private

  def pet_application_params
    params.require(:pet_application).permit(:pet_id).merge(adopter_profile: current_user.profile)
  end
end
