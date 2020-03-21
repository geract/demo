class Users::V1::Rescuers::MessagesController < Users::V1::Rescuers::BaseController
  def index
    render json: { messages: Messages::IndexPresenter.new(current_user.organization.messages) }, status: :ok
  end

  def create
    message = current_user.organization.messages.build(message_params)
    message.sender = current_user

    if message.save
      render json: { message: Messages::ShowPresenter.new(message) }
    else
      head :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:pet_id, :message)
  end

end

