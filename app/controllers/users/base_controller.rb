class Users::BaseController < ApplicationController
  before_action :authenticate_user!
  include DeviseTokenAuth::Concerns::SetUserByToken
  authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    render json: {}, status: :forbidden
  end
end
