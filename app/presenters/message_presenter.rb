class MessagePresenter
  def initialize(message)
    @message = message
  end

  def response
    {
      id: message.id,
      message: message.message,
      pet_id: message.pet_id
    }
  end

  private

  attr_reader :message
end
