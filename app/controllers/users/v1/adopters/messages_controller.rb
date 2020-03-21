class Users::V1::Adopters::MessagesController < Users::V1::Adopters::BaseController
  def index
    render json: { messages: Messages::IndexPresenter.new(current_user.messages) }
  end

  def create
    message = current_user.messages.build(message_params)

    if message.save
      render json: { message: Messages::ShowPresenter.new(message) }
    else
      head :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:pet_id, :message, :organization_id)
  end

end

