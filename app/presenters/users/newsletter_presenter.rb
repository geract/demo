class Users::NewsletterPresenter
  def initialize(newsletter)
    @newsletter = newsletter
  end

  def response
    {
      id: newsletter.id,
      email: newsletter.email
    }
  end

  private

  attr_reader :newsletter
end
