class Users::V1::Rescuers::RescuersController < Users::V1::Rescuers::BaseController
  def index
    rescuers = current_user.organization.rescuers.by_status(params[:status]).order_by_name

    if rescuers
      render json: { rescuers: Rescuers::Profiles::IndexPresenter.new(rescuers) }
    else
      head :not_found
    end
  end

  def create
    rescuer = Rescuer.new(rescuer_params)
    rescuer.profile.organization_id = current_user.organization.id
    
    if rescuer.save
      render json: { rescuer: Rescuers::Profiles::ShowPresenter.new(rescuer) }
    else
      render json: { errors: rescuer.errors.full_messages }, status: :bad_request
    end
  end

  def show
    rescuer = current_user.organization.rescuers.find(params[:id])

    if rescuer
      render json: { rescuer: Rescuers::Profiles::ShowPresenter.new(rescuer) }
    else
      head :not_found
    end
  end

  def update
    rescuer = current_user.organization.rescuers.find(params[:id])

    if rescuer.update(rescuer_params)
      render json: { rescuer: Rescuers::Profiles::ShowPresenter.new(rescuer) }
    else
      render json: { errors: rescuer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def rescuer_params
    prepare_params
    params.require(:rescuer).permit(:email,
                                    profile_attributes: [:first_name, :last_name, :phone, :title, :photo])
  end

  def prepare_params
    params[:rescuer][:profile_attributes] ||= {
        first_name: params[:rescuer][:first_name],
        last_name: params[:rescuer][:last_name],
        title: params[:rescuer][:title],
        phone: params[:rescuer][:phone],
        photo: params[:rescuer][:photo]
      }
  end
end
