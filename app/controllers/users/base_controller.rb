class Users::BaseController < ApplicationController
  before_action :authenticate_user!
  include DeviseTokenAuth::Concerns::SetUserByToken

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
