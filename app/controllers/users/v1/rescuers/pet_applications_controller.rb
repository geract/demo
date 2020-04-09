class Users::V1::Rescuers::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pet_applications = PetApplication.all

    render json: {applications: Rescuers::PetApplications::IndexPresenter.new(pet_applications)}, status: :ok
  end
end
