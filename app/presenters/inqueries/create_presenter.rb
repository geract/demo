class Inqueries::CreatePresenter
  def initialize(inquery)
    @inquery = inquery
  end

  def as_json(*)
    Users::InqueryPresenter.new(inquery).response
  end

  private

  attr_reader :inquery
end
