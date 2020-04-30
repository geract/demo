class Users::V1::Rescuers::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pets = current_user.organization.pets.includes(:applications).by_status(filters_params[:status])
    pets = pets.remove_filters if filters_params.blank?

    render json: {applications: Rescuers::PetApplications::IndexPresenter.new(pets)}, status: :ok
  end

  private

  def filters_params
    return {} unless params[:filters]

    params.require(:filters).permit(:status)
  end
end
