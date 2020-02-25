class Users::V1::RescuersController < Users::BaseController

  def create
    @rescuer = Rescuer.new(rescuer_params)
    unless @rescuer.save
      render json: { errors: @rescuer.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @rescuer = Rescuer.find_by(id: params[:id])

    unless @rescuer
      render status: :not_found
    end
  end

  def update
    @rescuer = Rescuer.find_by(id: params[:id])

    unless @rescuer.update(rescuer_params)
      render json: { errors: @rescuer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def rescuer_params
    params.require(:rescuer).permit(:first_name, :last_name, :email, :phone)
  end
end
