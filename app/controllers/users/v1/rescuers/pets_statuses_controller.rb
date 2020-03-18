class Users::V1::Rescuers::PetsStatusesController < Users::V1::Rescuers::BaseController
  def update
    pet = current_user.organization.pets.friendly.find(params[:id])

    if Pet::UpdateStatus.perform(pet, pet_params[:status], pet_params)
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet) }
    else
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet), errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:status,
                                :reason_code)
  end
end
