class Users::V1::NewsletterController < Users::BaseController
  def create
    newsletter = Newsletter.new(newsletter_params)

    if Adopter::SaveNewsletterService.perform(newsletter)
      head :created
    else
      render json: { errors: newsletter.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:email)
  end
end
