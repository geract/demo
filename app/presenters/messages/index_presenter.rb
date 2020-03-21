class Messages::IndexPresenter
  def initialize(messages)
    @messages = messages
  end

  def as_json(*)
    messages.map{ |message| MessagePresenter.new(message).response }
  end

  private
  attr_reader :messages
end
