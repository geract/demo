class Users::V1::BaseController < Users::BaseController
  before_action :authenticate_user!
  include DeviseTokenAuth::Concerns::SetUserByToken

  def current_organization
    @current_organization ||= current_user.organization
  end
end
