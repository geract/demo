class Users::BaseController < ApplicationController
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
end
