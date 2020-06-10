class Users::V1::Rescuers::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pets = Pets::Search::Database.new.execute(status: filters_params[:status], organization: current_user.organization)

    response_with_presenter(pets: pets)
  end

  private

  def filters_params
    return {} unless params[:filters]

    params.require(:filters).permit(:status)
  end
end
