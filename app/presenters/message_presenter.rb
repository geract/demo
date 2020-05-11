class MessagePresenter
  def initialize(message)
    @message = message
  end

  def response
    {
      text: message.message,
      sender_id: message.senderable.id,
      sender_type: message.senderable.type
    }
  end

  private

  attr_reader :message
end
