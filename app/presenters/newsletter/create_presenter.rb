class Newsletter::CreatePresenter
  def initialize(newsletter)
    @newsletter = newsletter
  end

  def as_json(*)
    Users::NewsletterPresenter.new(newsletter).response
  end

  private

  attr_reader :newsletter
end
