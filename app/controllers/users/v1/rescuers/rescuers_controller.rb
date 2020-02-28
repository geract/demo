class Users::V1::Rescuers::RescuersController < Users::BaseController
  def index
    @rescuers = Rescuer.by_name_and_status(params[:status])

    render json: { rescuers: @rescuers }
  end

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
