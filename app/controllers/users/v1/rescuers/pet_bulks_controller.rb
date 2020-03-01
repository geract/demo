class Users::V1::Rescuers::PetBulksController < Users::V1::Rescuers::BaseController
  def update
    pets, errors = Pet::UpdateStatusBulk.perform(params['pets'], params['status'], 
                                                 organization_id: current_user.organization.id)

    status = errors.empty? ? :ok : :unprocessable_entity

    render json: { pets: pets, errors: errors }, status: status
  end
end
