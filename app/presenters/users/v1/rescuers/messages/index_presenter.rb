class Users::V1::Rescuers::Messages::IndexPresenter < BasePresenter
  def as_json(*)
    {
      messages: messages.map{ |message| Users::V1::Objects::MessagePresenter.to_json(message) }
    }
  end
end
