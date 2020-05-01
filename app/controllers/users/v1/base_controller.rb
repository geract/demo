class Users::V1::BaseController < Users::BaseController
  before_action :authenticate_user!
  include DeviseTokenAuth::Concerns::SetUserByToken
end
