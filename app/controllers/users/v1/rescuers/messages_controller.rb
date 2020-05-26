class Users::V1::Rescuers::MessagesController < Users::V1::Rescuers::BaseController
  def index
    pet_application = current_organization.pet_applications.includes(messages: :senderable).find(params[:pet_application_id])
    
    response_with_presenter(messages: pet_application.messages)
  end

  def create
    message = current_user.messages.build(
      pet_application_id: params[:pet_application_id],
      message: message_params[:message]
    )

    if message.save
      head :ok
    else
      render json: message.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end
end
