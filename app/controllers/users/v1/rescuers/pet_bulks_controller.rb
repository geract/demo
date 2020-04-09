class Users::V1::Rescuers::PetBulksController < Users::V1::Rescuers::BaseController
  def update
    pets, errors = Rescuer::UpdatePetStatusBulk.perform(params['pets'], params['status'], 
                                                 organization_id: current_user.organization.id)

    status = errors.empty? ? :ok : :unprocessable_entity

    render json: { pets: Rescuers::Pets::IndexPresenter.new(pets), errors: errors }, status: status
  end
end
