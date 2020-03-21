class Messages::ShowPresenter
  def initialize(message)
    @message = message
  end

  def as_json(*)
    MessagePresenter.new(@message).response
  end
end
