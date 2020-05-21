class RejectionSurveys::IndexPresenter
  def initialize(options)
    @options = options
  end

  def as_json(*)
    options
  end

  attr_reader :options
end
