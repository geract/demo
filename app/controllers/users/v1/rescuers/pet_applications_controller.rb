class Users::V1::Rescuers::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pets = Shared::SearchPet.perform(status: filters_params[:status], organization_id: current_user.organization_id)

    render json: {applications: Rescuers::PetApplications::IndexPresenter.new(pets)}, status: :ok
  end

  private

  def filters_params
    return {} unless params[:filters]

    params.require(:filters).permit(:status)
  end
end
