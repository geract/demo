class Users::V1::Adopters::MessagesController < Users::V1::Adopters::BaseController
  def index
    response_with_presenter(messajes: current_user.messages)
  end

  def create
    message = current_user.messages.build(message_params)

    if message.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:pet_id, :message, :organization_id)
  end
end

