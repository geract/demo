class Users::V1::Rescuers::PetBulksController < Users::BaseController
  def update
    pets, errors = Pet::UpdateBulk.perform(params['pets'], params['status'])

    status = errors.empty? ? :ok : :unprocessable_entity

    render json: { pets: pets, errors: errors }, status: status
  end
end
