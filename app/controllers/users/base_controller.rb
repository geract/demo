class Users::BaseController < ApplicationController
  respond_to :json

  rescue_from CanCan::AccessDenied do |exception|
    render json: {}, status: :forbidden
  end

  private

  def render_error(status, message)
    response = {
      success: false,
      errors: [message]
    }
    render json: response, status: status
  end

  def response_with_presenter(**args)
    presenter_name = self.class.name.sub('Controller', "::#{action_name.capitalize}Presenter")
    presenter = presenter_name.constantize.new(self, args)
    respond_with(presenter)
  end
end
