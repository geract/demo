class Users::V1::PetsStatusesController < Users::BaseController
  def update
    pet = Pet.friendly.find(params[:id])

    if Pet::UpdateStatus.perform(pet, pet_params[:status], pet_params)
      render json: { pet: pet }
    else
      render json: { pet: pet, errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:status,
                                :reason_code)
  end
end
