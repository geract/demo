class Users::V1::Rescuers::RescuersController < Users::V1::Rescuers::BaseController
  def index
    @rescuers = current_user.organization.rescuers.by_status(params[:status]).order_by_name
  end

  def create
    @rescuer = Rescuer.new(rescuer_params)
    @rescuer.profile.organization_id = current_user.organization.id

    unless @rescuer.save
      render json: { errors: @rescuer.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @rescuer = current_user.organization.rescuers.find_by(id: params[:id])

    unless @rescuer
      render status: :not_found
    end
  end

  def update
    @rescuer = current_user.organization.rescuers.find_by(id: params[:id])

    unless @rescuer.update(rescuer_params)
      render json: { errors: @rescuer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def rescuer_params
    prepare_params
    params.require(:rescuer).permit(:email, 
                                    profile_attributes: [:first_name, :last_name, :phone, :status])
  end

  def prepare_params
    params[:rescuer][:profile_attributes] ||= {
        first_name: params[:rescuer][:first_name],
        last_name: params[:rescuer][:last_name],
        phone: params[:rescuer][:phone],
      }
  end
end
