class Users::V1::NewsletterController < Users::BaseController
  def create
    newsletter = Newsletter.new(newsletter_params)

    if Adopter::SaveNewsletter.perform(newsletter)
      render json: {newsletter: Newsletter::CreatePresenter.new(newsletter)}, status: :ok
    else
      render json: {newsletter: Newsletter::CreatePresenter.new(newsletter), errors: newsletter.errors.messages}, status: :unprocessable_entity
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:email)
  end
end
