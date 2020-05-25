class Users::V1::Objects::MessagePresenter
  def self.to_json(message)
    {
      text: message.message,
      sender_id: message.senderable.id,
      sender_type: message.senderable.type
    }
  end
end
