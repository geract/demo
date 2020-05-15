class Users::V1::Rescuers::RescuerStatusesController < Users::V1::Rescuers::BaseController
  def update
    rescuer = current_user.organization.rescuers.find(params[:id])

    if Rescuer::UpdateStatusService.perform(rescuer, rescuer_params[:status])
      render json: { rescuer: Rescuers::Profiles::ShowPresenter.new(rescuer) }
    else
      render json: { rescuer: rescuer, errors: rescuer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def rescuer_params
    params.require(:rescuer).permit(:status)
  end
end
