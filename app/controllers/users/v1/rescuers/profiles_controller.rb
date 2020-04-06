class Users::V1::Rescuers::ProfilesController < Users::V1::Rescuers::BaseController
  def show
    if current_user.profile
      render json: Rescuers::Profiles::ShowPresenter.new(current_user)
    else
      head :not_found
    end
  end

  def update
    if current_user.update(profile_params)
      render json: Rescuers::Profiles::ShowPresenter.new(current_user)
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    prepare_params
    params.require(:rescuer).permit(:email,
                                    :password,
                                    :password_confirmation,
                                    profile_attributes: [:first_name, :last_name, :phone, :title, :photo])
  end

  def prepare_params
    params[:rescuer][:profile_attributes] ||= {
        first_name: params[:rescuer][:first_name],
        last_name: params[:rescuer][:last_name],
        title: params[:rescuer][:title],
        phone: params[:rescuer][:phone],
        photo: params[:rescuer][:photo],
      }
  end
end
